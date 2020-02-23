//
//  NewsService.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift

enum NewsTarget {
    case fetchTopHeadlines(_ params: [String: Any])
    case everything(_ params: [String: Any])
}
extension NewsTarget : TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL())!
    }
    
    var path: String {
        switch self {
        case .fetchTopHeadlines:
            return "top-headlines"
        case .everything:
            return "everything"
        }
    }
    
    var method: Moya.Method {
         return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .fetchTopHeadlines(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .everything(let params):
             return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }

    
}

protocol NewsProtocol {
    func fetchTL(_ params: [String: Any]) -> Observable<[Article]>
    
    func fetchEveryThing(_ params: [String: Any]) -> Observable<[Article]>
}

struct NewsService : NewsProtocol {
    
    let provider : MoyaProvider<NewsTarget>
    
    func fetchTL(_ params: [String : Any]) -> Observable<[Article]> {
        return self.provider.rx.request(.fetchTopHeadlines(params)).map(AppPaging.self)
            .asObservable()
            .map { $0.articles}
    }
    
    func fetchEveryThing(_ params: [String : Any]) -> Observable<[Article]> {
        return self.provider.rx.request(.everything(params)).map(AppPaging.self)
            .asObservable()
            .map { $0.articles}
    }
    
}
