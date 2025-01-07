//
//  buttonExtentions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit

extension UIButton {
    func configureButton(
        title: String,
        titleColor: UIColor? = .label,
        buttonBackgroundColor: UIColor? = .white,
        titleFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: .semibold),
        buttonCornerRaduis: CGFloat? = 10,
        icon: String? = nil,
        iconColor: UIColor? = UIColor.textRed,
        haveBorder: Bool = false,
        borderColor: UIColor? = .lightGrey,
        borderWidth: CGFloat? = 1
    ) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = titleFont
        backgroundColor = buttonBackgroundColor
        layer.cornerRadius = buttonCornerRaduis!

        if let icon = icon {
            setTitleColor(iconColor, for: .normal)
            setImage(UIImage(systemName: icon), for: .normal)
            tintColor = iconColor
            semanticContentAttribute = .forceRightToLeft
        }

        if haveBorder {
            layer.borderWidth = borderWidth!
            layer.borderColor = borderColor?.cgColor
        }
    }
}

