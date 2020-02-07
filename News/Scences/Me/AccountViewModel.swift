//
//  AccountViewModel.swift
//  AMP
//
//  Created by Trung Vu on 5/21/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

struct AccountViewModel {
    
    var service: AccountService!
    
    let accountDataSource : PublishSubject<[SectionModel<String, CellModel>]> = PublishSubject()
    
    var phoneNumber = BehaviorRelay<String>(value: "")
    
    var birthDay = BehaviorRelay<String>(value: "")
    
    var gender = BehaviorRelay<String>(value: "")
    
    var maritalStatus = BehaviorRelay<String>(value: "")
    
    var profession = BehaviorRelay<String>(value: "")
    
    var isPhoneNumberValid : Observable<Bool> {
        return phoneNumber.asObservable().map({ number in
            return number.length > 0
        })
    }
    
    var isBirthDayNotEmpty: Observable<Bool> {
        return birthDay.asObservable().map({ (birthDay) in
            return birthDay.length > 0
        })
    }
    
    var isBirthDayValid: Observable<Bool> {
        return birthDay.asObservable().map({ (birthDay) in
            return birthDay.length > 0
        })
    }
    
    var isGenderNotEmpty: Observable<Bool> {
        return gender.asObservable().map({ (gender) in
            return gender.length > 0
        })
    }
    
    var isMartialStatusNotEmpty: Observable<Bool> {
        return maritalStatus.asObservable().map({ (status) in
            return status.length > 0
        })
    }
    
    var isProfessionNotEmpty: Observable<Bool> {
        return profession.asObservable().map({ (profession) in
            return profession.length > 0
        })
    }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(isPhoneNumberValid.asObservable(), isBirthDayValid.asObservable()) {(phoneValid, birthValid) in
            return phoneValid && birthValid
        }
    }
    
    func createDataSource() -> Observable<[SectionModel<String, CellModel>]> {
        let user = service.retrieveAccount()
        var ds =  [SectionModel<String, CellModel>]()
        let avartar = AccountData(id: .avatar, propertyName: "avatar", propertyValue: "")
        
        ds.append(SectionModel(model: "header", items: [CellModel.avatar(data: avartar)]))
        
        let name = AccountData(id: .name, propertyName: "Name", propertyValue: user?.email)
        
        let mobilePhone = AccountData(id: .mobilePhone, propertyName: "Phone", propertyValue: user?.phone)
        
        let email = AccountData(id: .email , propertyName: "Email", propertyValue: user?.email)
        
        ds.append(SectionModel(model: "fieldData", items: [
            CellModel.propertyField(data: name),
            CellModel.phoneNumber(data: mobilePhone),
            CellModel.propertyField(data: email),
           ]))
        ds.append(SectionModel(model: "save", items: [CellModel.buttonSave]))
        
        return Observable.just(ds)
    }
}
