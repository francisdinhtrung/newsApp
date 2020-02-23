//
//  LoginViewModel.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EZSwiftExtensions

struct LoginViewModel {
    
    let emailRxText = BehaviorRelay<String>(value: "")
    
    let passwordRxText = BehaviorRelay<String>(value: "")
    
    lazy var rxDisposeBag = DisposeBag()
    
    //tracking error
    let errorTracker = ErrorTracker()
    
    //tracking indicator
    let activityIndicator = ActivityIndicator()
    
    var isValidEmail : Observable<Bool> {
        return emailRxText.asObservable().map ({ email in
            return email.isValidEmail()
        })
    }
    var isValidPass: Observable<Bool> {
        return passwordRxText.asObservable().map({ pass in
            return !pass.isEmpty
        })
    }
    
    var isValid : Observable<Bool> {
        return Observable.combineLatest(emailRxText.asObservable(), passwordRxText.asObservable()) { e, p in
            !e.isEmpty && e.isValidEmail() && !p.isEmpty
        }
    }
    
    var service: AuthenService!
}

extension LoginViewModel: ViewModelType {
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        
        let form = Driver.combineLatest(isValid.asDriverOnErrorJustComplete(), self.emailRxText.asDriver(), self.passwordRxText.asDriver())
        
        let submit = input.trigger.withLatestFrom(form)
            .flatMap { (valid, email, password) -> Driver<UserProfile> in
                let payload = LoginPayload(username: email, password: password)
                return self.service.save(payload: payload)
                    .trackError(self.errorTracker)
                    .trackActivity(self.activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(error: self.errorTracker.asDriver(), loading: self.activityIndicator.asDriver(), loginSuccess: submit)
    }
    
    struct Input {
        let trigger : Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let loginSuccess: Driver<UserProfile>
    }
}
