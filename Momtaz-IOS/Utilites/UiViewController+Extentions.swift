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
        let storyBoard = UIStoryboard(name: name.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(identifier: identifier) as! Self
    }
    enum StoryboardEnum: String {
        case main = "Main"
        case Order = "Auth"
        case NearbyCafes = "workAgenda"
        case Reserve = "Reservation"
        
    }
}
