//
//  RoundedTextField.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import UIKit

@IBDesignable
class RoundedTextField: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var prefixImageView: UIImageView!
    @IBOutlet weak var textFieldView: UITextField!
    @IBOutlet weak var actionButtonUI: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    var delegate : RoundedTextfieldDelegate?
    
    private func loadView() {
        let bundel = Bundle.init(for: RoundedTextField.self)
        bundel.loadNibNamed(RoundedTextField.nibName, owner: self)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.border_width = 0.1
        self.border_color = .lightGrey
        self.prefix_icon = nil

        self.addSubview(self.contentView)
        
        self.textFieldView.delegate = self
        self.textFieldView.addTarget(self, action: #selector(textfieldDidEndEditing(sender: )), for: .editingDidEnd)
        self.textFieldView.addTarget(self, action: #selector(textfieldValueChanged(sender: )), for: .editingDidEnd)
    }
    
    @objc func textfieldDidEndEditing(sender: UITextField){
        delegate?.textFieldDidEndEditing(textfield: self)
        self.endEditing(true)
    }
    @objc private func textfieldValueChanged(sender: UITextField) {
        delegate?.textFieldDidChange(text: sender.text, textfield: self)
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        UIView.transition(with: textFieldView, duration: 0.2, options: .transitionCrossDissolve) {[weak self] in
            guard let self = self else {return}
            if let isPasswordField = currentPasswordState {
                currentPasswordState = isPasswordField == .hidden ? .shown : .hidden
            }
        }
    }
    
    
    //MARK: create view attribute
    @IBInspectable
    var background_Color: UIColor? {
        get{return self.contentView.backgroundColor}
        set(color){
            self.contentView.backgroundColor = color
        }
    }
    
    @IBInspectable
    var border_color : UIColor? {
        get {
            guard let color = self.contentView.layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set(color){
            self.contentView.layer.borderColor = color?.cgColor
        }
    }
    
    @IBInspectable
    var border_width : CGFloat {
        get{return CGFloat(Float(self.contentView.layer.borderWidth))}
        set(width){
            self.contentView.layer.borderWidth = width
        }
    }
    
    @IBInspectable
    var cornerRaduis : Float{
        get{return Float(self.contentView.layer.cornerRadius)}
        set(cornerRaduis){
            self.contentView.layer.cornerRadius = CGFloat(cornerRaduis)
        }
    }
    
    //MARK: create textField attribute
    @IBInspectable
    var placeHolder : String? {
        get{return self.textFieldView.placeholder}
        set(placeholder){
            self.textFieldView.placeholder = placeholder
        }
    }
    var text: String? {
        return textFieldView.text
    }
    
    func setText(_ newText: String) {
        textFieldView.text = newText
    }
    
    
    //MARK: create prefix icon attribute
    @IBInspectable
    var prefix_icon : UIImage? {
        get{return self.prefixImageView.image}
        set{
            if let newValue {
                self.prefixImageView.image = newValue
                self.prefixImageView.isHidden = false
                self.prefixImageView.tintColor = .lightGray
                return
            }
            self.prefixImageView.image = nil
            self.prefixImageView.isHidden = true
        }
    }
    @IBInspectable
    var prefixIconColor : UIColor? {
        get{return self.prefixImageView.tintColor}
        set{
            guard let color = newValue else { return }
            self.prefixImageView.tintColor = color
            
        }
    }
    
    //MARK: action Button
    @IBInspectable
    var disableActionButton : Bool {
        get{return false}
        set(value){
            if (value) {
                self.actionButtonUI.isHidden = true
            }
        }
    }
    
    @IBInspectable
    var disableActionButtonColor : UIColor? {
        get{return self.actionButtonUI.imageView?.tintColor}
        set{
            guard let color = newValue else { return }
            self.actionButtonUI.imageView?.tintColor = color
            
        }
    }
    
    @IBInspectable
    var secureText : Bool {
        get{return false}
        set(value){
            if(value){
                currentPasswordState = .hidden
                self.textFieldView.isSecureTextEntry = true
            }
        }
    }
    
    private var _secureImage = UIImage(systemName: "eye.fill")
    private var _unSecureImage = UIImage(systemName: "eye.slash.fill")
    
    private enum PasswordStates {
        case hidden
        case shown
    }
    
    private var currentPasswordState : PasswordStates? {
        willSet{
            guard let value = newValue else { return }
            let image = value == .hidden ? _unSecureImage : _secureImage
            self.actionButtonUI.setImage(image, for: .normal)
            self.textFieldView.isSecureTextEntry = value == .hidden
            
        }
    }
    
}

extension RoundedTextField : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldDidBeginEditing(textfield: self)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.endEditing(true)
        switch reason {
            case .committed:
                break
            case .cancelled:
                delegate?.textFieldDidEndEditing(textfield: self)
            @unknown default:
                break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldDidEndEditing(textfield: self)
        self.endEditing(true)
        return true
    }
    
}

protocol RoundedTextfieldDelegate : AnyObject {
    func textFieldDidChange(text: String?, textfield: RoundedTextField)
    func textFieldDidBeginEditing(textfield: RoundedTextField)
    func textFieldDidEndEditing(textfield: RoundedTextField)
    func textFieldDidClearText(textfield: RoundedTextField)
}

extension RoundedTextfieldDelegate {
    func textFieldDidChange(text: String?, textfield: RoundedTextField){}
    func textFieldDidBeginEditing(textfield: RoundedTextField){}
    func textFieldDidEndEditing(textfield: RoundedTextField){}
    func textFieldDidClearText(textfield: RoundedTextField){}
}

