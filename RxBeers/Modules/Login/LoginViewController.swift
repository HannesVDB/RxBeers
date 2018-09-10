//
//  LoginViewController.swift
//  RxBeers
//
//  Created by Hannes Van den Berghe on 10/09/2018.
//  Copyright © 2018 icapps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    var viewModel: LoginViewModel = LoginViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Login"
        
        setupBindings()
    }

    private func setupBindings() {

        loginButton
            .rx
            .tap
            .subscribe(viewModel.in.loginTapped)
            .disposed(by: disposeBag)

        usernameTextField
            .rx
            .text
            .subscribe(viewModel.in.username)
            .disposed(by: disposeBag)

        passwordTextField
            .rx
            .text
            .subscribe(viewModel.in.password)
            .disposed(by: disposeBag)

        viewModel
            .out
            .success
            .subscribe(onNext: { success in
                if success {
                    let controller = BeersViewController.build()
                    self.navigationController?.show(controller, sender: self)
                } else {
                    print("👽 Something went wrong don't navigate")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
