//
//  NetworkProvider.swift
//  2T-CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import Moya

class NetworkProvider<T: TargetType> {
    
    static func build() -> MoyaProvider<T> {
        return MoyaProvider<T>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    }
    
    private static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
}
extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
