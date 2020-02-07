//
//  String+Ext.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        //"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return regCheck(regEx: regEx)
    }
    
    private func regCheck(regEx: String) -> Bool {
        let regTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return regTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[~!@#$%^&*()_+|}{:\"?><.]).{8,}$"
        return regCheck(regEx: regEx)
    }
}
