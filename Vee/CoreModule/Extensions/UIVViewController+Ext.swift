//
//  UIVViewController+Ext.swift
//  CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Get a instance of View Controller by Generic Type
    ///
    /// - Parameter viewControllerIdentifier: determine a identifier
    /// - Returns: Instance of Generic Type
    public static func instantiateViewController<T>(_ name: UIStoryboard.StoryBoardApp) -> T {
        Log.debug("StoryBoard: \(name)")
        let uiStoryboard = UIStoryboard(name: name.rawValue, bundle: .main)
        return uiStoryboard.instantiateViewController(withIdentifier: self.identity()) as! T
    }
    
    public static func identity() -> String {
        return String(describing: self)
    }
    
    func navigate(_ navigation: MyNavigation) {
        navigate(navigation as Navigation)
    }
}
