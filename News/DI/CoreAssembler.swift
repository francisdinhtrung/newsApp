//
//  CoreAssembler.swift
//  News
//
//  Created by Trung Vu on 2/6/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import Swinject
import Moya



class CoreAssembler: Assembly {
    
    init() {}
    
    func assemble(container: Container) {
        
        //MARK: - Log
        Log.debug("Hi I'm Assembly")
        
        container.register(DataProvider.self) { r in
            let dataProvider: DataProvider = DataProvider()
            return dataProvider
        }.inObjectScope(.container)
        
        container.register(AuthenService.self) { r in
            let authenService: AuthenService = AuthenService()
            return authenService
        }.inObjectScope(.container)
        
        container.register(AccountService.self) { r in
            let accountService: AccountService = AccountService()
            return accountService
        }.inObjectScope(.container)
        
        //register usecase
        container.register(MoyaProvider<NewsTarget>.self){  r in
            return MoyaProvider<NewsTarget>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
        }.inObjectScope(.container)
        
        container.register(NewsService.self) { r in
            let newsService: NewsService = NewsService(provider: r.resolve(MoyaProvider<NewsTarget>.self)!)
            return newsService
        }.inObjectScope(.container)
        
        
        container.register(RegisterViewModel.self) { r in
            var registerViewModel: RegisterViewModel = RegisterViewModel()
            registerViewModel.service = mainAssembleResolver.resolve(AccountService.self)
            return registerViewModel
        }.inObjectScope(.container)
        
        container.register(LoginViewModel.self) { r in
            var registerViewModel: LoginViewModel = LoginViewModel()
            registerViewModel.service = mainAssembleResolver.resolve(AuthenService.self)
            return registerViewModel
        }.inObjectScope(.container)
        
        container.register(HomeViewModel.self) { r in
            let homeViewModel: HomeViewModel = HomeViewModel()
            homeViewModel.service = mainAssembleResolver.resolve(NewsService.self)
            return homeViewModel
        }.inObjectScope(.container)
        
        container.register(DiscoveryViewModel.self) { r in
            let homeViewModel: DiscoveryViewModel = DiscoveryViewModel()
            homeViewModel.service = mainAssembleResolver.resolve(NewsService.self)
            return homeViewModel
        }.inObjectScope(.container)
        
        container.register(AccountViewModel.self) { r in
            var newsService: AccountViewModel = AccountViewModel()
            newsService.service = mainAssembleResolver.resolve(AccountService.self)
            return newsService
        }.inObjectScope(.container)
    }
}
