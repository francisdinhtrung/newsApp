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
import TimelineTableViewCell
import SwifterSwift
import PureLayout

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let loadMore = BehaviorRelay<Bool>(value: false)
    
    let loadPageTrigger = PublishSubject<Void>()
    
    let loadNextPageTrigger = PublishSubject<Void>()
    
    var viewModel: HomeViewModel!
    
    private var dataSource : RxTableViewSectionedReloadDataSource<SectionItemGoalList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        bindingModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPageTrigger.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupTableView() {
        
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
            bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        self.tableView.autoPinEdge(toSuperviewEdge: .top, withInset: -height)
        
        self.tableView.delegate = self
        
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
        

        self.tableView.rx.modelSelected(Article.self).subscribe(onNext: { [weak self](item) in
            if let strongSelf = self {
                if let vc = mainAssembleResolver.resolve(NewsDetailViewController.self) {
                    strongSelf.navigationController?.pushViewController(vc)
                }
            }
        }).disposed(by: rxDisposeBag)
        
    }
    
    private func bindingModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = HomeViewModel.Input(trigger: viewWillAppear, loadPageTrigger: self.loadPageTrigger, loadNextPageTrigger: loadNextPageTrigger)
        
        let output = viewModel.transform(input: input)
        
        //Bind histories to UITableView
        output.dataSources.drive(self.tableView.rx.items(dataSource: self.dataSource)).disposed(by: rxDisposeBag)
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
    private func dataSourceConfiguration() -> RxTableViewSectionedReloadDataSource<SectionItemGoalList> {
        return RxTableViewSectionedReloadDataSource<SectionItemGoalList>(configureCell: { [weak self] (ds, tableView, indexPath, sectionViewModel) -> UITableViewCell in
            guard let strongSelf = self else { return UITableViewCell() }
            
            return strongSelf.createCreateHistoryCell(tableView, indexPath, sectionViewModel)
            })
    }
    
    private func createCreateHistoryCell(_ tableView: UITableView, _ indexPath: IndexPath,_ article: Article?) -> TimelineTableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TimelineTableViewCell.self, for: indexPath)
        cell.timelinePoint = TimelinePoint()
        cell.timeline.frontColor = UIColor.red
        cell.timeline.backColor = UIColor.red
        cell.titleLabel.text = "12:30"
        cell.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        cell.lineInfoLabel.text = "lineInfo"
        
        cell.viewsInStackView = []

        cell.illustrationImageView.image = UIImage(named: "mail")
        return cell
    }
}


struct SectionItemGoalList {
  var header: String
  var items: [Item]
}

extension SectionItemGoalList: SectionModelType {
  typealias Item = Article

   init(original: SectionItemGoalList, items: [Item]) {
    self = original
    self.items = items
  }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeaderView.loadFromNib(named: "HomeHeaderView")
        return header
    }
}
