//
//  Alert.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/12/2024.
//

import Foundation
import UIKit

class Alert {
    
    func showAlertWithNegativeAndPositiveButtons(title: String , msg: String , negativeButtonTitle: String , positiveButtonTitle: String , negativeButtonHandlerTapped: ((UIAlertAction) -> ())? = nil , positiveButtonHandlerTapped:  @escaping ((UIAlertAction) -> ())) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: negativeButtonTitle, style: .cancel, handler: negativeButtonHandlerTapped))
        alert.addAction(UIAlertAction(title: positiveButtonTitle, style: .default, handler: positiveButtonHandlerTapped))
        return alert
    }
    
    func showAlertWithOnlyPositiveButtons(title: String , msg: String , positiveButtonTitle: String , positiveButtonHandlerTapped:  ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positiveButtonTitle, style: .cancel, handler: positiveButtonHandlerTapped))
        return alert
    }
}
