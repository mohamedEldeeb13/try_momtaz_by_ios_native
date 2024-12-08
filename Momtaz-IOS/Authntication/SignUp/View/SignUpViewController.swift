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
    
    //MARK: Design
    
    private func setupIntailUI(){
        setupLogoInNavigationBar()
        setupSignupButtonUI()
        setupTermsAndConditionsButtonUI()
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.setBackIndicatorImage(UIImage(systemName: "arrowshape.left.circle.fill"), transitionMaskImage: UIImage(systemName: "arrowshape.left.circle.fill"))
        
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear

        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .red

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
        self.dismiss(animated: true)
    }
    
    
    //MARK: prepare Alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
    }
}

