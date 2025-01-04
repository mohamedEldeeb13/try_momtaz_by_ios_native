//
//  MainNavigationController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 19/12/2024.
//

import Foundation
import UIKit

class MainNavigationController : UINavigationController , UIGestureRecognizerDelegate {
    
    //MARK: Appearance struct
    struct AppearanceTheme {
        let appearanceForegroundColor : UIColor
        let appearanceBackgroundColor : UIColor?
        let appearanceFont : UIFont
        let appearanceLargeTitleFont : UIFont
        
        static let `default` : AppearanceTheme = AppearanceTheme(
            appearanceForegroundColor: .label,
            appearanceBackgroundColor: .navigationBar,
            appearanceFont: .systemFont(ofSize: 20 , weight: .medium),
            appearanceLargeTitleFont: .systemFont(ofSize: 34, weight: .bold))
    }
    
    convenience init(root: UIViewController , theme : AppearanceTheme = .default) {
        self.init(rootViewController: root)
        self.setupAppearance(with: theme)
    }
    
    //MARK: General setup Appearance
    private func setupAppearance(with theme : AppearanceTheme){
        
        // Attributes for title and large title text
        let attributes : [NSAttributedString.Key : Any] = [
            .foregroundColor : theme.appearanceForegroundColor,
            .font : theme.appearanceFont
        ]
        
        let attributeForLargeTitle : [NSAttributedString.Key : Any] = [
            .foregroundColor: theme.appearanceForegroundColor,
            .font: theme.appearanceLargeTitleFont
        ]
        
        
        // Configure the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        
        //MARK: 1- Set the custom back button icon
        let backButtonImage = UIImage(systemName: "arrowshape.backward.circle.fill")?.withTintColor(.darkGrey , renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.titleTextAttributes = attributes
        appearance.largeTitleTextAttributes = attributeForLargeTitle
        
        appearance.backgroundColor = theme.appearanceBackgroundColor
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        //MARK: 2- Apply the appearance to the navigation bar
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
        // Set the logo image in the title view in center
        setLogoInTitleView()
        
        // Add the notification and message buttons
        setupLeftBarButtons()
        
    }
    
    //MARK: 3- Add a centered logo in the navigation bar
    func setLogoInTitleView() {
        let logoImage = UIImageView(image: UIImage(named: "momtaz_logo"))
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        titleView.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: titleView.topAnchor),
            logoImage.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            logoImage.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        self.navigationBar.topItem?.titleView = titleView
    }
    
    // MARK: 4- Add notification and message button
    func setupLeftBarButtons() {
        // Create the notification button
        let notificationButton = BadgeButton()
        notificationButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        notificationButton.tintColor = .darkGrey
        notificationButton.badgeValue = 5
        notificationButton.imageView?.contentMode = .scaleAspectFit
        notificationButton.contentHorizontalAlignment = .fill
        notificationButton.contentVerticalAlignment = .fill
        // Set the size of the notification button
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        
        // Create the messages button
        let messagesButton = BadgeButton()
        messagesButton.setImage(UIImage(systemName: "message.fill"), for: .normal) // Use system message icon
        messagesButton.tintColor = .darkGrey
        messagesButton.badgeValue = 2
        messagesButton.imageView?.contentMode = .scaleAspectFit
        messagesButton.contentHorizontalAlignment = .fill
        messagesButton.contentVerticalAlignment = .fill
        // Set the size of the notification button
        messagesButton.translatesAutoresizingMaskIntoConstraints = false
        messagesButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        messagesButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        messagesButton.addTarget(self, action: #selector(messagesButtonTapped), for: .touchUpInside)
        
        // Wrap buttons in UIBarButtonItems
        let notificationBarButton = UIBarButtonItem(customView: notificationButton)
        let messageBarButton = UIBarButtonItem(customView: messagesButton)
        
        // Add them to the left bar button items
        self.navigationBar.topItem?.leftBarButtonItems = [notificationBarButton , messageBarButton]
       
        
    }
    // Add these actions for the buttons
    @objc private func notificationButtonTapped() {
        print("Notification button tapped")
        // Handle navigation or logic here
    }

    @objc private func messagesButtonTapped() {
        print("Messages button tapped")
        // Handle navigation or logic here
    }
    
    //MARK: setup Gesture
    private func setupGesture() {
        interactivePopGestureRecognizer?.delegate = self
        self.view.semanticContentAttribute = .forceLeftToRight
//      self.view.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        
    }
    
    // MARK: - Deinit -
    deinit {
        print("class is deinit, No memory leak found")
    }
}


