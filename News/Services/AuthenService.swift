//
//  AuthenService.swift
//  News
//
//  Created by Trung Vu on 2/6/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import Realm
import RealmSwift

struct AuthenService {
    
    func save(payload: LoginPayload) -> Observable<UserProfile> {
        return Observable<UserProfile>.create { obs in
            let profile = dataProvider.object(UserProfile.self, key: payload.username)
            if profile == nil || profile!.password != payload.password {
                obs.onError(AppError(message: "UserName or Password is invalid.", statusCode: 400))
                obs.onCompleted()
                return Disposables.create()
            }
            obs.onNext(profile!)
            obs.onCompleted()
            return Disposables.create()
        }
    }

}
