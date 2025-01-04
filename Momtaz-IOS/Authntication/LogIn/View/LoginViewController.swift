//
//  LoginViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class LoginViewController: UIViewController{
    
    //MARK: components outlet
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    
    private let viewModel : LoginViewModelProtocol = LoginViewModel()
    private let bag = DisposeBag()
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntailUI()
        allBindingFunctions()
    }
    
    //MARK: setup intail design
    
    private func setupIntailUI(){
        setupLoginButton()
    }
    // prepare login button
    private func setupLoginButton(){
        loginButtonUI.layer.cornerRadius = loginButtonUI.frame.height / 2
        loginButtonUI.clipsToBounds = true
    }
    
    
    
    //MARK: action tapped buttons
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewModel.validationAndLogIn()
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
    
    //MARK: navigation to main tab bar
    func navigateToMainTabBar() {
        let mainTabBarController = MainTabBarViewController()
        let navigationController = MainNavigationController(root: mainTabBarController)
        self.sceneDelegate?.window?.rootViewController = navigationController

    }
}


//MARK: all binding functions
extension LoginViewController {
    
    private func allBindingFunctions() {
        bindToViewModel()
        subscribeWithLoginStates()
    }
    
    private func bindToViewModel() {
        phoneNumberTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.phoneNumberTextBehavorail).disposed(by: bag)
        passwordTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.passwordTextBehavorail).disposed(by: bag)
        
    }
    
    private func subscribeWithLoginStates(){
        viewModel.input.LoginStatesPublisher.subscribe(onNext: {[weak self] loginStates in
            guard let self = self else{return}
            switch loginStates {
            case .showLoading:
                ProgressHUD.animate("Loading...")
            case .hideLoading:
                ProgressHUD.dismiss()
            case .success:
                navigateToMainTabBar()
            case .failure(let errorMessage):
                showAlert(title: Constants.warning, message: errorMessage)
            }
        }).disposed(by: bag)
    }
}
