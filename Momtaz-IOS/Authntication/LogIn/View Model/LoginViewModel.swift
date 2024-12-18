//
//  LoginViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol ViewModel : AnyObject {
    associatedtype Input
    associatedtype Output
}

//MARK: Login Protocol
protocol LoginViewModelProtocol : AnyObject {
    var input : LoginViewModel.Input {get}
    var output : LoginViewModel.Output {get}
    func validationAndLogIn()
}

//MARK: Login States
enum LoginStates {
    case showLoading
    case hideLoading
    case success
    case failure(String)
}

class LoginViewModel : LoginViewModelProtocol , ViewModel {
    
    //MARK: Input Class
    class Input{
        var phoneNumberTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var passwordTextBehavorail : BehaviorRelay<String> = .init(value: "")
        var LoginStatesPublisher : PublishSubject<LoginStates> = .init()
    }
    var input: Input = .init()
    
    
    //MARK: OutPut Class
    class Output {}
    var output: Output = .init()
    
    
    //MARK: Validation function
    func validationAndLogIn(){
//        return Observable.create { observer in
            do{
                // Check if phone number is empty
                guard !self.input.phoneNumberTextBehavorail.value.isEmpty else {
                            throw ValidationError.emptyPhoneNumber
                        }
                        
                // Check if password is empty
                guard !self.input.passwordTextBehavorail.value.isEmpty else {
                            throw ValidationError.emptyPassword
                        }
                
                login()
                
            }catch{
                // Push the error message to the output
                self.input.LoginStatesPublisher.onNext(.failure(error.localizedDescription))
        }
    }
    
    // MARK: - Login Function (with Alamofire POST request)
    
    private func login(){
        self.input.LoginStatesPublisher.onNext(.showLoading)
            
        let loginURL = URLs.shared.getLoginURL()
        let loginParameters: [String: Any] = [
            "email": self.input.phoneNumberTextBehavorail.value + "@momtaz.com",
            "password": self.input.passwordTextBehavorail.value
        ]
            
            // Alamofire POST request
        NetworkManager.shared.postData(url: loginURL, parameters: loginParameters) { (response: LogInResponse?, statusCode) in
            self.input.LoginStatesPublisher.onNext(.hideLoading)
            if let statusCode = statusCode , (200...299).contains(statusCode) {
                if response?.authorization?.token != nil {
                    UserDefaultsManager.shared.setAccessToken( response?.authorization?.token ?? "")
                    self.input.LoginStatesPublisher.onNext(.success)
    //              Complete the stream (no more updates will be sent)
                    self.input.LoginStatesPublisher.onCompleted()
                }else{
                    self.input.LoginStatesPublisher.onNext(.hideLoading)
                    self.input.LoginStatesPublisher.onNext(.failure("not have token please try in another time"))
                }
            }else{
                self.input.LoginStatesPublisher.onNext(.hideLoading)
                self.input.LoginStatesPublisher.onNext(.failure("Your email or password is incorrect"))
            }
        }
    }
}

