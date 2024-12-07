//
//  ForgetPasswordViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    //MARK: components outlet
    @IBOutlet weak var scrollViewController: UIScrollView!
    @IBOutlet weak var EmailOrPhoneNumberTextFieldView: RoundedTextField!
    @IBOutlet weak var changePasswordButtonUI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToDismissKeyboard()
        setupForgetPasswordButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers(scrollView: scrollViewController )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
    }
    
    
    //MARK: prepare components ui
    
    // prepare login button
    private func setupForgetPasswordButtonUI(){
        changePasswordButtonUI.layer.cornerRadius = changePasswordButtonUI.frame.height / 2
        changePasswordButtonUI.clipsToBounds = true
    }
}
