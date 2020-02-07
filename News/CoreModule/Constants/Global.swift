//
//  Global.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let keyWindow = {
    return UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene})
    .compactMap({$0})
    .first?.windows
    .filter({$0.isKeyWindow}).first
}()

let CachePath: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    if let cachePath = paths.first {
        return cachePath
    }
    return NSTemporaryDirectory()
} ()

let RealmPath: String = {
    return CachePath + "/Realm/"
} ()

let dataProvider :DataProvider = {
    return (mainAssembleResolver.resolve(DataProvider.self) ?? DataProvider())
}()


