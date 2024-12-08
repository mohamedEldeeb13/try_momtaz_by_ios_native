//
//  LoginViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation
class LoginViewModel {
    
    //MARK: Varaibles
    var phoneNumber: String?
    var password: String?
    var errorMessage: String?
    
    
    func validateAndLogIn() -> Bool {
            do {
                
                // Validate phone number
                _ = try ValidationService.validate(phone: phoneNumber)
                
                // Validate password
                _ = try ValidationService.validate(password: password)
                
                // If all validations pass, return true
                return true
            } catch {
                // If validation fails, assign the error message
                self.errorMessage = error.localizedDescription
                return false
            }
        }
    
}
