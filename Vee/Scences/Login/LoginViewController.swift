//
//  LoginViewController.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import RxSwift
import RxCocoa
class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleUI()
        binding()
        dymmy()
    }
    
    func styleUI() {
        emailTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        passwordTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        loginButton.setCornerRadius(radius: 5)
        
        emailTextField.setCornerRadius(radius: 5)
        
        passwordTextField.setCornerRadius(radius: 5)
        
        viewModel.isValid.asObservable()
            .subscribe(onNext: { [weak self] v in
                guard let strongSelf = self else { return }
                strongSelf.loginButton.backgroundColor = v ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
            }).disposed(by: rxDisposeBag)
    }
    
    func dymmy() {
        #if DEBUG
        emailTextField.text = "trung@gmail.com"
        passwordTextField.text = "123123@Ddmin"
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func handleLogin(_ sender: Any) {
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        self.navigate(.register)
    }
    
    private func binding() {
        self.emailTextField.rx.text.map{ $0 ?? ""}.bind(to: viewModel.emailRxText).disposed(by: rxDisposeBag)
        self.passwordTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.passwordRxText).disposed(by: rxDisposeBag)
        viewModel.isValid.bind(to: self.loginButton.rx.isEnabled).disposed(by: rxDisposeBag)
        
        let input = LoginViewModel.Input(trigger: self.loginButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.error.drive(self.rx.error).disposed(by: rxDisposeBag)
        output.loading.drive(self.rx.isLoading).disposed(by: rxDisposeBag)
        output.loginSuccess.drive(self.profileBinding).disposed(by: rxDisposeBag)
    }
    
    var profileBinding: Binder<UserProfile> {
        return Binder(self, binding: { (vc, p) in
            LoginManager.showMainFlow(keyWindow)
            Context.setToken(p.email ?? "")
        })
    }
}
