//
//  RegisterViewController.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var viewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        dummy()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func binding() {
        
        self.emailTextField.rx.text.map{ $0 ?? ""}.bind(to: viewModel.email).disposed(by: rxDisposeBag)
        self.passwordTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.password).disposed(by: rxDisposeBag)
        self.confirmPasswordTextField.rx.text.map{ $0 ?? ""}.bind(to: viewModel.confirmPassword).disposed(by: rxDisposeBag)
        self.phoneTextField.rx.text.map{ $0 ?? ""}.bind(to: viewModel.phone).disposed(by: rxDisposeBag)
        viewModel.isValid.bind(to: self.createButton.rx.isEnabled).disposed(by: rxDisposeBag)
        
        let input = RegisterViewModel.Input(createAccountTrigger: self.createButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.error.drive(self.rx.error).disposed(by: rxDisposeBag)
        output.isLoading.drive(self.rx.isLoading).disposed(by: rxDisposeBag)
        output.responseSigup.drive(self.profileBinding).disposed(by: rxDisposeBag)
    }
    
    private func styleUI() {
        
        emailTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        passwordTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        confirmPasswordTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        phoneTextField.addBorder(width: 1, color: UIColor.gray.withAlphaComponent(0.4))
        
        createButton.setCornerRadius(radius: 5)
        
        emailTextField.setCornerRadius(radius: 5)
        passwordTextField.setCornerRadius(radius: 5)
        confirmPasswordTextField.setCornerRadius(radius: 5)
        phoneTextField.setCornerRadius(radius: 5)
        
        viewModel.isValid.asObservable()
                   .subscribe(onNext: { [weak self] v in
                       guard let strongSelf = self else { return }
                       strongSelf.createButton.backgroundColor = v ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
                   }).disposed(by: rxDisposeBag)
    }
    
    private func dummy() {
        emailTextField.text = "trung@gmail.com"
        phoneTextField.text = "+84914523342"
        passwordTextField.text = "123123@Ddmin"
        confirmPasswordTextField.text = "123123@Ddmin"
    }

    
    var profileBinding: Binder<UserProfile> {
        return Binder(self, binding: { (vc, p) in
            LoginManager.showMainFlow(keyWindow)
        })
    }
}
