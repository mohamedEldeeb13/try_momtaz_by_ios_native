//
//  LoginViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import UIKit

class LoginViewController: UIViewController{
    
    //MARK: components outlet
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    
    private let viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToDismissKeyboard()
        setupLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers(scrollView: scrollViewController )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Update ViewModel properties
                viewModel.phoneNumberFromLogIn = phoneNumberTextFieldView.text ?? ""
                viewModel.passwordFromLogIn = passwordTextFieldView.text ?? ""
        // Perform validation
               let validationResult = viewModel.areFieldsValid(fromLogin: true)
               if validationResult.isValid {
                   print("LogIn Success")
               } else {
                   showAlert(title: Constants.warning, message: validationResult.message ?? "")
               }
    }
    
    @IBAction func ForgetPasswordButtonTapped(_ sender: Any) {
        let controller = ForgetPasswordViewController.instantiat(name: .main)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let controller = SignUpViewController.instantiat(name: .main)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.viewModel = viewModel
        self.present(controller, animated: true)
    }
    
    
    //MARK: prepare components ui
    
    // prepare login button
    private func setupLoginButton(){
        loginButtonUI.layer.cornerRadius = loginButtonUI.frame.height / 2
        loginButtonUI.clipsToBounds = true
    }
    
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
    }
}

