//
//  SignUpViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation

class SignUpViewModel {
    
    //MARK: Varaibles
       var fullName: String?
       var phoneNumber: String?
       var password: String?
       var confirmPassword: String?
       var isTermsAccepted: Bool = false
       var errorMessage: String?
    
    
    func validateAndSignUp() -> Bool {

            do {
                _ = try ValidationService.validate(name: fullName)
                _ = try ValidationService.validate(phone: phoneNumber)
                let validatedPassword = try ValidationService.validate(password: password)
                _ = try ValidationService.validate(newPassword: validatedPassword, confirmPassword: confirmPassword)
                _ = try ValidationService.validate(termesAgreed: isTermsAccepted)
                
                // If all validations pass, return true
                return true
            } catch {
                // If validation fails, assign the error message
                self.errorMessage = error.localizedDescription
                return false
            }
        
        }
}
