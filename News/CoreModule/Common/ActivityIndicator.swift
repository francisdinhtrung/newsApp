//
//  ActivityIndicator.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ActivityIndicator: SharedSequenceConvertibleType {
    public typealias E = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    
    private let _lock = NSRecursiveLock()
    private let _behavior = BehaviorRelay<Bool>(value: false)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    
    public init() {
        _loading = _behavior.asDriver()
            .distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        _lock.lock()
        _behavior.accept(true)
        _lock.unlock()
    }
    
    private func sendStopLoading() {
        _lock.lock()
        _behavior.accept(false)
        _lock.unlock()
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
        return _loading
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}

