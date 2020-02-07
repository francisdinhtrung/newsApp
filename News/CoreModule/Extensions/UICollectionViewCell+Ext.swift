//
//  UICollectionViewCell+Ext.swift
//  CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    public static func identity() -> String {
        return String(describing: self)
    }
}


extension UICollectionView {
    public func registerCellNib(_ anyclass: AnyClass) {
        self.register(UINib(nibName: String(describing: anyclass.self), bundle:  Bundle(for: anyclass)), forCellWithReuseIdentifier: String(describing: anyclass.self))
    }
}
