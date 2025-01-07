//
//  Alert.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/12/2024.
//

import Foundation
import UIKit

class Alert {
    
    // MARK: - Show Alert with Two Buttons
        static func showAlertWithNegativeAndPositiveButtons(
            on viewController: UIViewController,
            title: String,
            message: String,
            positiveButtonTitle: String,
            negativeButtonTitle: String,
            positiveButtonStyle: UIAlertAction.Style = .default,
            negativeButtonStyle: UIAlertAction.Style = .cancel,
            positiveHandler: ((UIAlertAction) -> Void)? = nil,
            negativeHandler: ((UIAlertAction) -> Void)? = nil
        ) {
            let alert = createAlertController(
                title: title,
                message: message,
                positiveButtonTitle: positiveButtonTitle,
                negativeButtonTitle: negativeButtonTitle,
                positiveButtonStyle: positiveButtonStyle,
                negativeButtonStyle: negativeButtonStyle,
                positiveHandler: positiveHandler,
                negativeHandler: negativeHandler
            )
            viewController.present(alert, animated: true)
        }

        // MARK: - Show Alert with One Button
        static func showAlertWithOnlyPositiveButtons(
            on viewController: UIViewController,
            title: String,
            message: String,
            buttonTitle: String,
            buttonStyle: UIAlertAction.Style = .default,
            buttonHandler: ((UIAlertAction) -> Void)? = nil
        ) {
            let alert = createAlertController(
                title: title,
                message: message,
                positiveButtonTitle: buttonTitle,
                positiveButtonStyle: buttonStyle,
                positiveHandler: buttonHandler
            )
            viewController.present(alert, animated: true)
        }

        // MARK: - Private Alert Creation Method
        private static func createAlertController(
            title: String,
            message: String,
            positiveButtonTitle: String,
            negativeButtonTitle: String? = nil,
            positiveButtonStyle: UIAlertAction.Style = .default,
            negativeButtonStyle: UIAlertAction.Style = .cancel,
            positiveHandler: ((UIAlertAction) -> Void)? = nil,
            negativeHandler: ((UIAlertAction) -> Void)? = nil
        ) -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // Add Positive Button
            let positiveAction = UIAlertAction(title: positiveButtonTitle, style: positiveButtonStyle, handler: positiveHandler)
            alert.addAction(positiveAction)
            
            // Add Negative Button if Provided
            if let negativeTitle = negativeButtonTitle {
                let negativeAction = UIAlertAction(title: negativeTitle, style: negativeButtonStyle, handler: negativeHandler)
                alert.addAction(negativeAction)
            }
            
            return alert
        }
}
