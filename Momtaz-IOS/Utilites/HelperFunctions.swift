//
//  HelperFunctions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 01/01/2025.
//

import Foundation
import UIKit

class HelperFunctions {
    static func getStudentLevel(levelName: String, classRoomNumber: String) -> String {
        if levelName == "المرحلة الابتدائيه" || levelName == "Primary" {
            switch classRoomNumber {
            case "1":
                return "First year of primary school"
            case "2":
                return "Second year of primary school"
            case "3":
                return "Third year of primary school"
            case "4":
                return "fourth year of primary school"
            case "5":
                return "fifth year of primary school"
            case "6":
                return "Sixth year of primary school"
            default:
                return "-"
            }
        } else if levelName == "المرحلة الاعدادية" || levelName == "Secondary" {
            switch classRoomNumber {
            case "1":
                return "First year of Secondary school"
            case "2":
                return "Second year of Secondary school"
            case "3":
                return "Third year of Secondary school"
            default:
                return "-"
            }
        } else {
            switch classRoomNumber {
            case "1":
                return "First year of high school"
            case "2":
                return "Second year of high school"
            case "3":
                return "Third year of high school"
            default:
                return "-"
            }
        }
    }
    
    //MARK: formate phone number to chat
    static func formatPhoneNumber(_ phoneNumber: String, country: String) -> String {
        // Remove any non-digit characters
        let digits = phoneNumber.filter { "0123456789".contains($0) }
        
        // Check the length of the phone number and the country
        if country.lowercased() == "egypt" {
            if digits.count == 11 {
                // Add "+20" if the number has 11 digits
                return "+20" + digits
            } else if digits.count == 12 {
                // Add "+2" if the number has 12 digits (assuming it includes a leading 0)
                return "+2" + digits
            }
        } else if country.lowercased() == "saudi" {
            if digits.count == 9 {
                // Add "+966" if the number has 9 digits
                return "+966" + digits
            } else if digits.count == 10 {
                if digits.hasPrefix("0") {
                    // Remove the leading 0 and add "+966"
                    let newNumber = String(digits.dropFirst())
                    return "+966" + newNumber
                } else {
                    // Add "+966" if the number does not start with 0
                    return "+966" + digits
                }
            }
        }
        
        // Return the original number if it doesn't match the expected lengths
        return phoneNumber
    }
    
    //MARK: handle function to open calling app
    static func openCallingApp(
            with phoneNumber: String,
            on viewController: UIViewController
        ) {
            
            if let url = URL(string: "tel://\(phoneNumber)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Handle the error
                    Alert.showAlertWithOnlyPositiveButtons(on: viewController, title: Constants.warning, message: "Unable to make a call", buttonTitle: Constants.ok)
                }
            }
        }
    
    //MARK: handle function to open whats app
    static func openWhatsAppChat(
            with phoneNumber: String,
            country: String,
            on viewController: UIViewController
        ) {
            // Format the phone number based on the country
            let formattedPhone = HelperFunctions.formatPhoneNumber(phoneNumber, country: country)
            let urlStr = "https://api.whatsapp.com/send?phone=\(formattedPhone)"
            
            // Attempt to open WhatsApp
            if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Show fallback message if WhatsApp is not installed
                Alert.showAlertWithOnlyPositiveButtons(
                    on: viewController,
                    title: Constants.warning,
                    message: "WhatsApp is not installed",
                    buttonTitle: Constants.ok
                )
            }
        }
}
