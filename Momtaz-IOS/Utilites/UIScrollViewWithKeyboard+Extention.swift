//
//  UIScrollViewWithKeyboard+Extention.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/12/2024.
//

import Foundation
import UIKit

//MARK: handle UIScrollView with keyboard as extention work with any class as type of UIViewController

extension UIViewController {
    
    //MARK: add observable for UIKeyboardWillShow and UIKeyboardWillHide notification and handel functions
    func addKeyboardObservers(scrollView: UIScrollView) {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
                self?.keyboardWillShow(notification: notification, scrollView: scrollView)
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
                self?.keyboardWillHide(notification: notification, scrollView: scrollView)
            }
        }

    // handel function for keyboard will show
        private func keyboardWillShow(notification: Notification, scrollView: UIScrollView) {
            guard let userInfo = notification.userInfo,
                  let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            scrollView.contentInset = contentInset
        }
    // handel function for keyboard will hide
        private func keyboardWillHide(notification: Notification, scrollView: UIScrollView) {
            scrollView.contentInset = UIEdgeInsets.zero
        }

    //MARK: Remove observable
        func removeKeyboardObservers() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        // MARK: - Tap Gesture to Dismiss Keyboard
        func addTapGestureToDismissKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
            view.addGestureRecognizer(tapGesture)
        }

        @objc private func didTapView() {
            view.endEditing(true)
        }
}
