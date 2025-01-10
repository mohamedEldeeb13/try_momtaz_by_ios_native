//
//  CustomBannerView.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/01/2025.
//

import UIKit

class Banner {
    
    // Private function to create the banner
    private static func createBanner(message: String, title: String, iconName: String, titleColor: UIColor, iconColor: UIColor , completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        // Banner container
        let bannerHeight: CGFloat = 80
        let banner = UIView(frame: CGRect(x: 16, y: -bannerHeight + 20, width: window.frame.width - 32, height: bannerHeight))
        banner.backgroundColor = .white
        banner.layer.borderColor = UIColor.lightGray.cgColor
        banner.layer.borderWidth = 1
        banner.layer.cornerRadius = 8
        banner.clipsToBounds = true
        
        // Horizontal Stack
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 12
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Icon
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = iconColor
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Vertical Stack for Labels
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 4
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = titleColor
        
        // Message Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = titleColor
        messageLabel.numberOfLines = 0
        
        // Add labels to vertical stack
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(messageLabel)
        
        // Add icon and vertical stack to horizontal stack
        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(verticalStack)
        
        // Add horizontal stack to banner
        banner.addSubview(horizontalStack)
        
        // Auto Layout for horizontal stack
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -12),
            horizontalStack.centerYAnchor.constraint(equalTo: banner.centerYAnchor)
        ])
        
        // Add banner to window
        window.addSubview(banner)
        
        // Animate banner
        UIView.animate(withDuration: 0.5, animations: {
            banner.frame.origin.y = 60 // Show below status bar
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseInOut, animations: {
                banner.frame.origin.y = -bannerHeight // Slide back up
            }, completion: { _ in
                banner.removeFromSuperview()
                // Call the completion handler if it's provided
                completion?()
            })
        }
    }
    
    // Error Banner
    static func showErrorBanner(message: String, title: String = Constants.error ,  completion: (() -> Void)? = nil) {
         createBanner(message: message, title: title, iconName: "multiply.circle.fill", titleColor: .textRed, iconColor: .textRed , completion: completion)
        
    }
    
    // Success Banner
    static func showSuccessBanner(message: String, title: String = Constants.success , completion: (() -> Void)? = nil) {
        createBanner(message: message, title: title, iconName: "checkmark.circle.fill", titleColor: .systemGreen, iconColor: .systemGreen , completion: completion)
    }

}
