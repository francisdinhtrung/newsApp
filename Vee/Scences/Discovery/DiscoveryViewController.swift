//
//  DiscoveryViewController.swift
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

class DiscoveryViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let loadMore = BehaviorRelay<Bool>(value: false)
    
    let loadPageTrigger = PublishSubject<Void>()
    
    let loadNextPageTrigger = PublishSubject<Void>()
    
    var viewModel: DiscoveryViewModel!
    
//    private var dataSource : RxTableViewSectionedReloadDataSource<ArticleSection>!
//
    var selectedTopic = 0
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//
//        bindingModel()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.loadPageTrigger.onNext(())
//    }
    
//    private func setupTableView() {
//        self.tableView.registerCellNib(ArticleCell.self)
//
//        self.tableView.es.addPullToRefresh { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.loadPageTrigger.onNext(())
//        }
//
//        self.tableView.es.addInfiniteScrolling { [weak self] in
//            guard let strongSelf = self else { return }
//            if !(strongSelf.viewModel.hasReachedMax.value) {
//                strongSelf.loadNextPageTrigger.onNext(())
//            } else {
//                strongSelf.tableView.es.stopLoadingMore()
//            }
//        }
//
//        //dynamic height
//        self.tableView.estimatedRowHeight = UITableView.automaticDimension
//
//        //datasource
//        self.dataSource = dataSourceConfiguration()
//
//        self.tableView.rx.setDelegate(self)
//
//    }
//
//    private func bindingModel() {
//        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
//            .mapToVoid()
//            .asDriverOnErrorJustComplete()
//
//        let input = DiscoveryViewModel.Input(trigger: viewWillAppear, loadPageTrigger: self.loadPageTrigger, loadNextPageTrigger: loadNextPageTrigger)
//
//        let output = viewModel.transform(input: input)
//
//        //Bind histories to UITableView
//        output.dataSources.drive(tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self)) { tv, viewModel, cell in
//            cell.binding(viewModel.article)
//        }.disposed(by: rxDisposeBag)
//
//        output.error.drive(self.rx.error)
//            .disposed(by: rxDisposeBag)
//
//        output.loading.asObservable()
//        .subscribe(onNext: {[weak self] isloading in
//            guard let strongSelf = self else { return }
//            if !isloading {
//                strongSelf.tableView.es.stopPullToRefresh()
//                strongSelf.tableView.es.stopLoadingMore()
//            }
//        }).disposed(by: rxDisposeBag)
//
//    }
//
//    // datasource Config
//    private func dataSourceConfiguration() -> RxTableViewSectionedReloadDataSource<ArticleSection> {
//        return RxTableViewSectionedReloadDataSource<ArticleSection>(configureCell: { [weak self] (ds, tableView, indexPath, sectionViewModel) -> UITableViewCell in
//            guard let strongSelf = self else { return UITableViewCell() }
//
//            return strongSelf.createCreateHistoryCell(tableView, indexPath, sectionViewModel.dto)
//        })
//
//    }
//
//    private func createCreateHistoryCell(_ tableView: UITableView, _ indexPath: IndexPath,_ article: Article?) -> ArticleCell {
//        let cell = tableView.dequeueReusableCell(withClass: ArticleCell.self, for: indexPath)
//        return cell
//    }
}

//extension DiscoveryViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = DiscoveryHeader(frame: CGRect(x: 0, y: 0, w: UIScreen.main.bounds.width, h: 150))
//        header.selectedIndex = self.selectedTopic
//        header.selectedHandler = { [weak self] (index) in
//            if let strongSelf = self {
//                strongSelf.selectedTopic = index
//                strongSelf.viewModel.keyword.accept(DiscoveryHeader.keywords[index])
//                strongSelf.viewModel.elements.accept([])
//                strongSelf.loadPageTrigger.onNext(())
//            }
//        }
//        return header
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 150
//    }
//}
