//
//  UIView+Ext.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib(name nameFile: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nameFile, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

