//
//  TextField+Ext.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

extension UITextField {
    /// add padding left
    func addPaddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    open override func awakeFromNib() {
        addPaddingLeft()
    }
}
