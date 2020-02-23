//
//  ViewAssembler.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import Swinject

class ViewAssembler: Assembly {
    
    init() {}
    
    func assemble(container: Container) {
        
        //MARK: - Log
        Log.debug("Hi I'm Assembly")
        
        // MARK: Register main tabbar
        container.register(MainTabViewController.self) { r in
            let mainTabbarController: MainTabViewController =  MainTabViewController.instantiateViewController(.main)
            mainTabbarController.viewControllers?.forEach{ (vc) in
                switch (vc as? UINavigationController)?.topViewController {
                    case let homeVC as HomeViewController:
                         homeVC.viewModel = mainAssembleResolver.resolve(HomeViewModel.self)!
                case let discovery as DiscoveryViewController: break
//                    discovery.viewModel = mainAssembleResolver.resolve(DiscoveryViewModel.self)!
                case let meVc as MeViewController:
                    meVc.viewModel = mainAssembleResolver.resolve(AccountViewModel.self)!
                default:
                    break
                }
            }
            return mainTabbarController
        }
        
        container.register(HomeViewController.self) { r in
            let homeVc: HomeViewController =  HomeViewController.instantiateViewController(.main)
            return homeVc
        }
        
        container.register(DiscoveryViewController.self) { r in
            let discoveryVC: DiscoveryViewController =  DiscoveryViewController.instantiateViewController(.main)
            return discoveryVC
        }
        
        container.register(MeViewController.self) { r in
            let meVc: MeViewController =  MeViewController.instantiateViewController(.main)
            meVc.viewModel = mainAssembleResolver.resolve(AccountViewModel.self)
            return meVc
        }
        
        container.register(LoginViewController.self) { r in
            let loginVc: LoginViewController =  LoginViewController.instantiateViewController(.main)
            loginVc.viewModel = mainAssembleResolver.resolve(LoginViewModel.self)
            return loginVc
        }
        
        container.register(RegisterViewController.self) { r in
            let registerVc: RegisterViewController =  RegisterViewController.instantiateViewController(.main)
            registerVc.viewModel = mainAssembleResolver.resolve(RegisterViewModel.self)
            return registerVc
        }
        
        container.register(NewsDetailViewController.self) { r in
            let registerVc: NewsDetailViewController =  NewsDetailViewController.instantiateViewController(.main)
            return registerVc
        }
        
    }
}
