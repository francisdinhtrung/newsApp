//
//  HomeViewController.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import EZSwiftExtensions
import ESPullToRefresh
import SwifterSwift

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let loadMore = BehaviorRelay<Bool>(value: false)
    
    let loadPageTrigger = PublishSubject<Void>()
    
    let loadNextPageTrigger = PublishSubject<Void>()
    
    var viewModel: HomeViewModel!
    
    private var dataSource : RxTableViewSectionedReloadDataSource<ArticleSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        bindingModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPageTrigger.onNext(())
    }
    
    private func setupTableView() {
        self.tableView.registerCellNib(ArticleCell.self)
        
        self.tableView.es.addPullToRefresh { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadPageTrigger.onNext(())
        }
        
        self.tableView.es.addInfiniteScrolling { [weak self] in
            guard let strongSelf = self else { return }
            if !(strongSelf.viewModel.hasReachedMax.value) {
                strongSelf.loadNextPageTrigger.onNext(())
            } else {
                strongSelf.tableView.es.stopLoadingMore()
            }
        }
        
        //dynamic height
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        //datasource
        self.dataSource = dataSourceConfiguration()
        
        
        weak var weakSelf = self
        self.tableView.rx.modelSelected(ArticleViewModel.self).subscribe(onNext: { (item) in
            weakSelf?.navigate(.newsDetail(url: item.article.url ?? ""))
        }).disposed(by: rxDisposeBag)
        
    }
    
    private func bindingModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = HomeViewModel.Input(trigger: viewWillAppear, loadPageTrigger: self.loadPageTrigger, loadNextPageTrigger: loadNextPageTrigger)
        
        let output = viewModel.transform(input: input)
        
        //Bind histories to UITableView
        output.dataSources.drive(tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self)) { tv, viewModel, cell in
            cell.binding(viewModel.article)
        }.disposed(by: rxDisposeBag)
        
        output.error.drive(self.rx.error)
            .disposed(by: rxDisposeBag)
        
        output.loading.asObservable()
        .subscribe(onNext: {[weak self] isloading in
            guard let strongSelf = self else { return }
            if !isloading {
                strongSelf.tableView.es.stopPullToRefresh()
                strongSelf.tableView.es.stopLoadingMore()
            }
        }).disposed(by: rxDisposeBag)
   
    }
    
    // datasource Config
    private func dataSourceConfiguration() -> RxTableViewSectionedReloadDataSource<ArticleSection> {
        return RxTableViewSectionedReloadDataSource<ArticleSection>(configureCell: { [weak self] (ds, tableView, indexPath, sectionViewModel) -> UITableViewCell in
            guard let strongSelf = self else { return UITableViewCell() }
            
            return strongSelf.createCreateHistoryCell(tableView, indexPath, sectionViewModel.dto)
        })
    }
    
    private func createCreateHistoryCell(_ tableView: UITableView, _ indexPath: IndexPath,_ article: Article?) -> ArticleCell {
        let cell = tableView.dequeueReusableCell(withClass: ArticleCell.self, for: indexPath)
        return cell
    }
}


typealias ArticleSection = SectionModel<Int, ArticleSectionViewModel>

struct ArticleSectionViewModel: IdentifiableType, Equatable {
    
    private(set) var identity: Int
    
    let dto: Article?
    
    init(id: Int, article model: Article?) {
        identity = id
        dto = model
    }
    
    static func == (lhs: ArticleSectionViewModel, rhs: ArticleSectionViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
