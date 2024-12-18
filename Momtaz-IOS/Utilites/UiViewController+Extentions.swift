//
//  UiViewController+Extentions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import Foundation
import UIKit

//MARK: for normal push
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

//MARK: for change root when push
extension UIViewController {
    var appDelegate: AppDelegate {
         return UIApplication.shared.delegate as! AppDelegate
    }

    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate else { return nil }
            return delegate
        }
}
