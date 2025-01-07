//
//  SignUpViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class SignUpViewController: UIViewController {
    //MARK: components outlet
//    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var fullNameTextFieldView: RoundedTextField!
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var confirmPasswordTextFieldView: RoundedTextField!
    @IBOutlet weak var termsAndConditionButtonUI: UIButton!
    @IBOutlet weak var signUpButtonUI: UIButton!
    
    //MARK: page attributes
    private let viewModel : SignUpViewModelProtocol = SignUpViewModel()
    private let bag = DisposeBag()
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntailUI()
        bindingAllFunction()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? AuthNavigationController { navigationController.setLogoInTitleView()
        }
    }
    
    //MARK: Design
    private func setupIntailUI(){
        setupSignupButtonUI()
        setupTermsAndConditionsButtonUI()
    }
    
    // prepare login button
    private func setupSignupButtonUI(){
        signUpButtonUI.layer.cornerRadius = signUpButtonUI.frame.height / 2
        signUpButtonUI.clipsToBounds = true
    }
    
    private func setupTermsAndConditionsButtonUI(){
        termsAndConditionButtonUI.setImage(UIImage(systemName: "square"), for: .normal)
        termsAndConditionButtonUI.tintColor = .lightGray
    }
    
    //MARK: action tapped button
    @IBAction func termsAndConditionButtonTapped(_ sender: Any) {
        // Toggle the state of `isTermsAccepted`
            let currentState = viewModel.input.isTermsAccepted.value
            viewModel.input.isTermsAccepted.accept(!currentState)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
       
        viewModel.validationAndSignUp()
               
    }
    
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: All binding functions
extension SignUpViewController {
    private func bindingAllFunction(){
        bindToViewModel()
        subscribeWithIsAcceptTermsAndCondfitions()
        subscribeWithSignUpStates()
        
    }
    
    private func bindToViewModel(){
        fullNameTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.fullNameTextBehavorail).disposed(by: bag)
        phoneNumberTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.phoneNumberTextBehavorail).disposed(by: bag)
        passwordTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.passwordTextBehavorail).disposed(by: bag)
        confirmPasswordTextFieldView.rx.text.orEmpty.bind(to: viewModel.input.confirmPasswordTextBehavorail).disposed(by: bag)
    }
    
    private func subscribeWithIsAcceptTermsAndCondfitions(){
        viewModel.input.isTermsAccepted.subscribe { [weak self] isAccepted in
            guard let self = self else { return }
                let image = isAccepted ? "checkmark.square.fill" : "square"
                let tintColor = isAccepted ? UIColor.systemPurple : UIColor.lightGray
                self.termsAndConditionButtonUI.setImage(UIImage(systemName: image), for: .normal)
                self.termsAndConditionButtonUI.tintColor = tintColor
        
        }.disposed(by: bag)
    }
    
    private func subscribeWithSignUpStates(){
        viewModel.input.signUpStatesPublisher.subscribe { [weak self] SignUpStates in
            guard let self = self else{return}
            switch SignUpStates {
            case .showLoading:
                ProgressHUD.animate("Loading...")
            case .hideLoading:
                ProgressHUD.dismiss()
            case .success:
                print("success")
            case .failure(let errorMessage):
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
            }
        }.disposed(by: bag)
    }
}

