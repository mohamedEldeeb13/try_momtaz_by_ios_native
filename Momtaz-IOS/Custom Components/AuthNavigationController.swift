//
//  CustomNavigationController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/12/2024.
//

import UIKit

class AuthNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    //MARK: Appearance struct
    struct AppearanceTheme {
        let appearanceForegroundColor: UIColor
        let appearanceBackgroundColor: UIColor?
        let appearanceFont: UIFont
        let appearanceLargeTitleFont: UIFont

        static let `default`: AppearanceTheme = AppearanceTheme(
            appearanceForegroundColor: .label,
            appearanceBackgroundColor: .navigationBar,
            appearanceFont: .systemFont(ofSize: 20, weight: .medium),
            appearanceLargeTitleFont: .systemFont(ofSize: 34, weight: .bold)
        )
    }

    convenience init(root: UIViewController, theme: AppearanceTheme = .default) {
        self.init(rootViewController: root)
        self.setupAppearance(with: theme)
        self.setupGesture()
    }

    //MARK: General setup Appearance
    private func setupAppearance(with theme: AppearanceTheme) {
        
        // Attributes for title and large title text
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: theme.appearanceForegroundColor,
            .font: theme.appearanceFont
        ]
        let largeTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: theme.appearanceForegroundColor,
            .font: theme.appearanceLargeTitleFont
        ]
        
        // Configure the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        
        //MARK: 1- Set the custom back button icon
        let backButtonImage = UIImage(systemName: "arrowshape.backward.circle.fill")?.withTintColor(.darkGrey, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.titleTextAttributes = attributes
        appearance.largeTitleTextAttributes = largeTitleAttributes
        appearance.backgroundColor = theme.appearanceBackgroundColor
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        //MARK: 2- Apply the appearance to the navigation bar
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
        // Set the logo image in the title view in center
        setLogoInTitleView()
        
        // Add the localization button
        addLocalizationButton()
        
    }
    
    
    //MARK: 3- Add a centered logo in the navigation bar
     func setLogoInTitleView() {
        let logoImageView = UIImageView(image: UIImage(named: "momtaz_logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        titleView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: titleView.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        self.navigationBar.topItem?.titleView = titleView
    }
    
    // MARK: 4- Add localization button
        func addLocalizationButton() {
            let localizationButton = UIBarButtonItem(
                title: "Ar", // The button text
                style: .plain,
                target: self,
                action: #selector(handleLocalizationButtonTapped)
            )
            
            localizationButton.tintColor = .darkGrey // Customize color
            localizationButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)

            // Add the button to the right of the navigation bar
            self.navigationBar.topItem?.leftBarButtonItem = localizationButton
        }

        // Handle the localization button action
        @objc private func handleLocalizationButtonTapped() {
            print("Localization button tapped!")
            // Add your localization switching logic here
            // For example, toggle between Arabic and English
        }
    
    //MARK: setup Gesture
    private func setupGesture() {
        interactivePopGestureRecognizer?.delegate = self
        self.view.semanticContentAttribute = .forceLeftToRight
//        self.view.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }

    // MARK: - Deinit -
    deinit {
        print("class is deinit, No memory leak found")
    }
}
