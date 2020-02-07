//
//  HomeViewModel.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {

    var service : NewsService!
    
    let elements = BehaviorRelay<[ArticleViewModel]>(value:[])
    
    private var pageIndex: Int = 0
    
    private let error = PublishSubject<Error>()
    
    let hasReachedMax = BehaviorRelay<Bool>(value: false)
    
    lazy var rxDisposeBag = DisposeBag()
    
    //tracking error
    let errorTracker = ErrorTracker()
    
    //tracking indicator
    let activityIndicator = ActivityIndicator()
    
    struct Input {
        let trigger: Driver<Void>
        let loadPageTrigger: PublishSubject<Void>
        let loadNextPageTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let dataSources: Driver<[ArticleViewModel]>
        let error: Driver<Error>
        let loading: Driver<Bool>
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        
        let isLoading = self.activityIndicator.asDriver()
        
        // First time load date
        let loadRequest = input.loadPageTrigger.asObservable()
            .flatMapLatest { (_) -> Observable<[ArticleViewModel]> in
                self.pageIndex = 0
                return self.service.fetchTL(["pageSize": Constants.pageSize, "page": self.pageIndex, "country":  "us", "apiKey" : Constants.apiKey])
                    .trackError(self.errorTracker)
                    .observeOn(MainScheduler.instance)
                    .trackActivity(self.activityIndicator)
        }
        
        // Get more data by page
        let nextRequest = isLoading.asObservable()
            .sample(input.loadNextPageTrigger)
            .flatMapLatest { (_) -> Observable<[ArticleViewModel]> in
                self.pageIndex = self.pageIndex + 1
                return self.service.fetchTL(["pageSize": Constants.pageSize, "page": self.pageIndex, "country":  "us", "apiKey" : Constants.apiKey])
                    .trackError(self.errorTracker)
                    .observeOn(MainScheduler.instance)
                    .trackActivity(self.activityIndicator)
        }
        
        let request = Observable.of(loadRequest, nextRequest)
            .merge()
            .share(replay: 1)
        
        let response = request.flatMap { repositories -> Observable<[ArticleViewModel]> in
            request
                .do(onError: { _error in
                    self.error.onNext(_error)
                }).catchError({ error -> Observable<[ArticleViewModel]> in
                    Observable.empty()
                })
            }.share(replay: 1)
        
        // combine data when get more data by paging
        Observable
            .combineLatest(request, response, elements.asObservable()) { request, response, elements in
                self.hasReachedMax.accept(response.count < Constants.pageSize)
                return self.pageIndex == 0 ? response : elements + response
            }
            .sample(response)
            .bind(to: elements)
            .disposed(by: self.rxDisposeBag)
        
        return Output(dataSources: self.elements.asDriver(), error: self.errorTracker.asDriver(), loading: isLoading.asDriver())
    }
}



