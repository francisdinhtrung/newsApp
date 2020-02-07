//
//  UITableView+Ext.swift
//  CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import UIKit

extension UITableView {
    /// Register cell nib with an alternative identifier
    ///
    /// - Parameters:
    ///   - cellClass: Cell Class
    ///   - alternativeId: Identifier
    public func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass.self)
        let nib = UINib(nibName: identifier, bundle: Bundle(for: cellClass))
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func identity() -> String {
        return String(describing: self)
    }
}
