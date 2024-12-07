//
//  AuthenticationViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/12/2024.
//

import Foundation

class AuthenticationViewModel {
    // Properties to hold the text field values
    // login varaibles
    var phoneNumberFromLogIn: String = ""
    var passwordFromLogIn: String = ""
    // signUp variables
       var fullName: String = ""
       var phoneNumberFromSignUp: String = ""
       var passwordFromSignUp: String = ""
       var confirmPassword: String = ""
       var isTermsAccepted: Bool = false
    
    func areFieldsValid(fromLogin: Bool) -> (isValid: Bool, message: String?) {
        if fromLogin {
            if phoneNumberFromLogIn.isEmpty{
                return (false, Constants.emptyPhoneNumber)
            }
            if passwordFromLogIn.isEmpty {
                return (false , Constants.emptyPassword)
            }
            return (true , nil)
        }else{
            if fullName.isEmpty {
                        return (false, Constants.emptyUserName)
                    }
                    if phoneNumberFromSignUp.isEmpty {
                        return (false, Constants.emptyPhoneNumber)
                    }
                    if !isValidPhoneNumber(phoneNumber: phoneNumberFromSignUp) {
                        return (false, Constants.invalidPhoneNumber)
                    }
                    if passwordFromSignUp.isEmpty {
                        return (false, Constants.emptyPassword)
                    }
                    if !isValidPassword(password: passwordFromSignUp) {
                        return (false, Constants.invalidPassword)
                    }
                    if confirmPassword.isEmpty {
                        return (false, Constants.emptyComfirmPassword)
                    }
                    if passwordFromSignUp != confirmPassword {
                        return (false, Constants.passwordAndConfirmPasswordShouldBeTheSame)
                    }
                    if !isTermsAccepted {
                        return (false, Constants.acceptTermsAndConditions)
                    }
                    return (true, nil)
        }
    }
    
    private func isValidPassword(password: String) -> Bool {
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        }

        private func isValidPhoneNumber(phoneNumber: String) -> Bool {
            let phoneRegex = "^(5[0-9]{8}|05[0-9]{8}|\\+9665[0-9]{8})$"
            return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phoneNumber)
        }
    
}
