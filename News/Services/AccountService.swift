//
//  AccountService.swift
//  News
//
//  Created by Trung Vu on 2/6/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift
import Realm

struct AppError: Error, Codable {
    let message: String
    let statusCode: Int
}

struct AccountService {
    
    func createAccount(profile: UserProfile) -> Observable<UserProfile> {
        return Observable<UserProfile>.create { obs in
            if dataProvider.object(UserProfile.self, key: profile.email ?? "") != nil {
                let item = dataProvider.object(UserProfile.self, key: profile.email ?? "")
                Log.debug("Profile: \(item?.email ?? "")")
                obs.onError(AppError(message: "User has existed.", statusCode: 400))
            }
            dataProvider.add(profile)
            obs.onNext(profile)
            obs.onCompleted()
            return Disposables.create()
        }
    }
    
    func retrieveAccount() -> UserProfile?{
        if let profile = dataProvider.object(UserProfile.self, key: Context.getToken()){
            return profile
        }
        return nil
    }
}
