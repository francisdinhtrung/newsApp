//
//  MyNavigation.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

enum MyNavigation: Navigation {
    case home
    case discovery
    case profile(profileL: UserProfile)
    case login
    case register
}

struct MyAppNavigation: AppNavigation {

    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController? {
        if let navigation = navigation as? MyNavigation {
            switch navigation {
            case .home:
                return mainAssembleResolver.resolve(HomeViewController.self)
            case .discovery:
                return mainAssembleResolver.resolve(DiscoveryViewController.self)
            case .profile(_):
                return mainAssembleResolver.resolve(MeViewController.self)
            case .register:
                return mainAssembleResolver.resolve(RegisterViewController.self)
            case .login:
                return mainAssembleResolver.resolve(LoginViewController.self)
            }
        }
        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
      from.navigationController?.pushViewController(to, animated: true)
    }
}
