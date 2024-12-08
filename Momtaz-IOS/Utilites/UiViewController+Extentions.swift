//
//  UiViewController+Extentions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import Foundation
import UIKit

extension UIViewController{
    
   static var identifier : String {
        
       return String(describing: self)
        
    }
    static func instantiat(name: StoryboardEnum) -> Self {
        switch name {
                case .xib:
                    // For XIB-based View Controllers
                    return Self(nibName: identifier, bundle: nil)
                default:
                    // For Storyboard-based View Controllers
                    let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
                    return storyboard.instantiateViewController(identifier: identifier) as! Self
                }
    }
    enum StoryboardEnum: String {
        case Login = "LoginViewController"
        case SignUp = "SignUpViewController"
        case ForgetPassword = "ForgetPasswordViewController"
        case NearbyCafes = "workAgenda"
        case Reserve = "Reservation"
        case xib
        
    }
}
