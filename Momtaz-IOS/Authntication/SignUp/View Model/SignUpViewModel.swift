//
//  SignUpViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol SignUpViewModelProtocol : AnyObject {
    var input : SignUpViewModel.Input {get}
    var output : SignUpViewModel.Output {get}
    func  validationAndSignUp()
}

//MARK: Login States
enum SignUpStates {
    case showLoading
    case hideLoading
    case success
    case failure(String)
}


class SignUpViewModel : SignUpViewModelProtocol , ViewModel {
    
    
    //MARK: Input class
    class Input {
        var fullNameTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var phoneNumberTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var passwordTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var confirmPasswordTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var isTermsAccepted : BehaviorRelay<Bool> = .init(value: false)
        var signUpStatesPublisher : PublishSubject<SignUpStates> = .init()
        
    }
    var input: Input = .init()
    
    //MARK: output class
    class Output {
        
    }
    var output: Output = .init()
    
    
    
    
    func validationAndSignUp(){

            do {
                _ = try ValidationService.validate(name: input.fullNameTextBehavorail.value)
//                _ = try ValidationService.validate(phone: input.phoneNumberTextBehavorail.value)
                let validatedPassword = try ValidationService.validate(password: input.passwordTextBehavorail.value)
                _ = try ValidationService.validate(newPassword: validatedPassword, confirmPassword: input.confirmPasswordTextBehavorail.value)
                _ = try ValidationService.validate(termesAgreed: input.isTermsAccepted.value)
                
                // If all validations pass, return true
                signUp()
                
            } catch {
                // If validation fails, assign the error message
                self.input.signUpStatesPublisher.onNext(.failure(error.localizedDescription))
                
            }
        
        }
    
    private func signUp(){
        self.input.signUpStatesPublisher.onNext(.showLoading)
        let signUpURL = URLs.shared.getSignUpURL()
        let signUpParameters : [String : Any] = [
            "name": self.input.fullNameTextBehavorail.value,
            "phone": self.input.phoneNumberTextBehavorail.value,
            "password": self.input.passwordTextBehavorail.value
        ]
        NetworkManager.shared.postData(url: signUpURL, parameters: signUpParameters) { (response : SignUpResponse?, statusCode) in
            if let statusCode = statusCode, (200...299).contains(statusCode){
                if response?.errors == nil {
                    self.input.signUpStatesPublisher.onNext(.hideLoading)
                    self.input.signUpStatesPublisher.onNext(.success)
                    // Complete the stream (no more updates will be sent)
                    self.input.signUpStatesPublisher.onCompleted()
                }else{
                    self.input.signUpStatesPublisher.onNext(.hideLoading)
                    self.input.signUpStatesPublisher.onNext(.failure(response?.errors?.values.first?.first ?? ""))
                }
            }else{
                self.input.signUpStatesPublisher.onNext(.hideLoading)
                self.input.signUpStatesPublisher.onNext(.failure("Your phone is already used"))
            }
        }
    }
}
