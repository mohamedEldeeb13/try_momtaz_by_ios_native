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
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var subHeadTextLbl: UILabel!
    @IBOutlet weak var phoneTextLbl: UILabel!
    @IBOutlet weak var passwordTextLbl: UILabel!
    @IBOutlet weak var forgetPasswordButtonUI: UIButton!
    @IBOutlet weak var notHaveAccountButtonUI: UIButton!
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
        headTextLbl.text = Constants.loginHeadText
        subHeadTextLbl.text = Constants.loginSubHeadText
        phoneTextLbl.text = Constants.phoneNumber
        passwordTextLbl.text = Constants.password
        forgetPasswordButtonUI.setTitle(Constants.forgetPassword, for: .normal)
        notHaveAccountButtonUI.setTitle(Constants.notHaveAcccount, for: .normal)
        
        setupLoginButton()
    }
    // prepare login button
    private func setupLoginButton(){
        loginButtonUI.configureButton(title: Constants.login,buttonBackgroundColor: .authPurple, titleFont: UIFont.systemFont(ofSize: 17 , weight: .semibold), buttonCornerRaduis: 20, haveBorder: false)
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
                ProgressHUD.animate(Constants.loading)
            case .hideLoading:
                ProgressHUD.dismiss()
            case .success:
                navigateToMainTabBar()
            case .failure(let errorMessage):
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
            }
        }).disposed(by: bag)
    }
}
