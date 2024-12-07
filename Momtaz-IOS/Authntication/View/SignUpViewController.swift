//
//  SignUpViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: components outlet
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var fullNameTextFieldView: RoundedTextField!
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var confirmPasswordTextFieldView: RoundedTextField!
    @IBOutlet weak var termsAndConditionButtonUI: UIButton!
    @IBOutlet weak var signUpButtonUI: UIButton!
    
    //MARK: add pages attributes

    // Non-optional ViewModel instance
        var viewModel: AuthenticationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToDismissKeyboard()
        setupSignupButtonUI()
        setupTermsAndConditionsButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers(scrollView: scrollViewController )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func termsAndConditionButtonTapped(_ sender: Any) {
        viewModel!.isTermsAccepted.toggle()
        let image = viewModel!.isTermsAccepted ? "checkmark.square.fill" : "square"
        let tintColor = viewModel!.isTermsAccepted ? UIColor.lightPurple : UIColor.lightGray
        termsAndConditionButtonUI.setImage(UIImage(systemName: image), for: .normal)
        termsAndConditionButtonUI.tintColor = tintColor
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // Update ViewModel properties
                viewModel!.fullName = fullNameTextFieldView.text ?? ""
                viewModel!.phoneNumberFromSignUp = phoneNumberTextFieldView.text ?? ""
                viewModel!.passwordFromSignUp = passwordTextFieldView.text ?? ""
                viewModel!.confirmPassword = confirmPasswordTextFieldView.text ?? ""
        // Perform validation
               let validationResult = viewModel!.areFieldsValid(fromLogin: false)
               if validationResult.isValid {
                   print("SignUp Success")
               } else {
                   showAlert(title: Constants.warning, message: validationResult.message ?? "")
               }
    }
    
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: prepare components ui
    
    // prepare login button
    private func setupSignupButtonUI(){
        signUpButtonUI.layer.cornerRadius = signUpButtonUI.frame.height / 2
        signUpButtonUI.clipsToBounds = true
    }
    
    private func setupTermsAndConditionsButtonUI(){
        termsAndConditionButtonUI.setImage(UIImage(systemName: "square"), for: .normal)
        termsAndConditionButtonUI.tintColor = .lightGray
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
    }
}
