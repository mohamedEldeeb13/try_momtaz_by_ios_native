//
//  SignUpViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: components outlet
//    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var fullNameTextFieldView: RoundedTextField!
    @IBOutlet weak var phoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var passwordTextFieldView: RoundedTextField!
    @IBOutlet weak var confirmPasswordTextFieldView: RoundedTextField!
    @IBOutlet weak var termsAndConditionButtonUI: UIButton!
    @IBOutlet weak var signUpButtonUI: UIButton!
    
    //MARK: add pages attributes

    private let viewModel = SignUpViewModel()
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntailUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? BaseNavigationController { navigationController.setLogoInTitleView()
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
        viewModel.isTermsAccepted.toggle()
        let image = viewModel.isTermsAccepted ? "checkmark.square.fill" : "square"
        let tintColor = viewModel.isTermsAccepted ? UIColor.lightPurple : UIColor.lightGray
        termsAndConditionButtonUI.setImage(UIImage(systemName: image), for: .normal)
        termsAndConditionButtonUI.tintColor = tintColor
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // Update ViewModel properties
                viewModel.fullName = fullNameTextFieldView.text ?? ""
                viewModel.phoneNumber = phoneNumberTextFieldView.text ?? ""
                viewModel.password = passwordTextFieldView.text ?? ""
                viewModel.confirmPassword = confirmPasswordTextFieldView.text ?? ""
        // Perform validation
               let validationResult = viewModel.validateAndSignUp()
               if validationResult {
                   print("SignUp Success")
               } else {
                   showAlert(title: Constants.warning, message: (viewModel.errorMessage)!)
               }
    }
    
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: prepare Alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
    }
}

