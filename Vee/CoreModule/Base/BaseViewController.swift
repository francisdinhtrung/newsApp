//
//  BaseViewController.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
import UIAlertController_Blocks

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /// Show Alert on the current view controller
       func showAlert(title : String, message : String, cancelTitle : String?, okTitle : String?, cancelCallback : (() -> ())?, okCallBack: (() -> ())?) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           if let cancelTitle = cancelTitle {
               let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
                   cancelCallback?()
               })
               
               alertController.addAction(action)
           }
           
           if let okTitle = okTitle {
               let action = UIAlertAction(title: okTitle, style: .default, handler: { (action) in
                   okCallBack?()
               })
               
               alertController.addAction(action)
           }
           
           self.present(alertController, animated: true, completion: nil)
       }
}


extension Reactive where Base: BaseViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            if let e = error as? AppError {
                viewController.showAlert(title: "Error", message: e.message, cancelTitle: "OK", okTitle: nil, cancelCallback: nil, okCallBack: nil)
            }
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                SVProgressHUD.setDefaultStyle(.dark)
                if let view = UIApplication.topViewController()?.view {
                    SVProgressHUD.setContainerView(view)
                }
                SVProgressHUD.show()// or other show methods
            } else {
                SVProgressHUD.dismiss() // or other hide methods
            }
        }
    }
}
