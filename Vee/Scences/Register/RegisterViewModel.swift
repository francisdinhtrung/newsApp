//
//  RegisterViewModel.swift
//  News
//
//  Created by Trung Vu on 2/6/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm

struct RegisterViewModel {
    
    let email = BehaviorRelay<String>(value: "")
    
    let password = BehaviorRelay<String>(value: "")
    
    let confirmPassword = BehaviorRelay<String>(value: "")
    
    let phone = BehaviorRelay<String>(value: "")
    
    lazy var rxDisposeBag = DisposeBag()
    
    //tracking error
    let errorTracker = ErrorTracker()
    
    //tracking indicator
    let activityIndicator = ActivityIndicator()
    
    var service: AccountService!
    
    var isValidEmail: Observable<Bool> {
        return email.asObservable().map({ (email) -> Bool in
            return !email.isEmpty && email.isValidEmail()
        })
    }
    
    var isValidPassword: Observable<Bool> {
        return password.asObservable().map({ (password) -> Bool in
            return !password.isEmpty && password.isValidPassword()
        })
    }
    
    var isValidConfirmPassword: Observable<Bool> {
        return confirmPassword.asObservable().map({ (p) -> Bool in
            return !p.isEmpty && p.isValidPassword() && p == self.password.value
        })
    }
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isValidEmail, isValidPassword, isValidConfirmPassword, isValidPhone).map ({ (arg) -> Bool in
            let (email, pass, confirmPass, phone) = arg
            return email && pass && confirmPass && phone
        })
    }
    
    var isValidPhone : Observable<Bool> {
        return phone.asObservable().map({ (p) -> Bool in
            return !p.isEmpty
        })
    }
    
}

extension RegisterViewModel: ViewModelType {
    func transform(input: RegisterViewModel.Input) -> RegisterViewModel.Output {
        
        let verifycation = Driver.combineLatest(self.email.asDriver(), self.password.asDriver(), self.phone.asDriver(), self.isValid.asDriverOnErrorJustComplete())
        
        let creating = input.createAccountTrigger.withLatestFrom(verifycation)
            .flatMap{ (email, password, phone, isValid) -> Driver<UserProfile> in
                let profile = UserProfile.build()
                    .setEmail(email)
                    .setPhone(phone)
                    .setPassword(password)
                    .setCreateDate()
                return self.service.createAccount(profile: profile)
                    .observeOn(MainScheduler.instance)
                    .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .utility))
                    .trackError(self.errorTracker)
                    .trackActivity(self.activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(error: self.errorTracker.asDriver(), isLoading: self.activityIndicator.asDriver(), responseSigup: creating)
    }
    
    
    

    struct Input {
        let createAccountTrigger : Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let responseSigup: Driver<UserProfile>
    }
}

