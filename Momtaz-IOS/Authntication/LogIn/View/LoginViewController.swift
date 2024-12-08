//
//  LoginViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import UIKit

class LoginViewController: UIViewController{
    
    //MARK: components outlet
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    
    private let viewModel = LoginViewModel()
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntailUI()
    }

    
    //MARK: setup intail design
    
    private func setupIntailUI(){
        setupLogoInNavigationBar()
        setupLoginButton()
    }
    
    private func setupLogoInNavigationBar(){
        let myView = UIView()
        let imageView = UIImageView(image: .momtazLogo)
        imageView.contentMode = .scaleAspectFill // Adjust as per your requirement
        imageView.translatesAutoresizingMaskIntoConstraints = false
        myView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: myView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: myView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: myView.trailingAnchor).isActive = true
        
        self.navigationItem.titleView = myView
    }
    // prepare login button
    private func setupLoginButton(){
        loginButtonUI.layer.cornerRadius = loginButtonUI.frame.height / 2
        loginButtonUI.clipsToBounds = true
    }
    
    
    
    //MARK: action tapped button
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Update ViewModel properties
                viewModel.phoneNumber = phoneNumberTextFieldView.text ?? ""
                viewModel.password = passwordTextFieldView.text ?? ""
        // Perform validation
               let validationResult = viewModel.validateAndLogIn()
               if validationResult {
                   print("LogIn Success")
               } else {
                   showAlert(title: Constants.warning, message: viewModel.errorMessage!)
               }
    }
    
    @IBAction func ForgetPasswordButtonTapped(_ sender: Any) {
        let controller = ForgetPasswordViewController.instantiat(name: .xib)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let controller = SignUpViewController.instantiat(name: .xib)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: prepare Alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
    }
}


