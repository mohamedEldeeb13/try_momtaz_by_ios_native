//
//  CustomNavigationController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 07/12/2024.
//

import UIKit

class CustomNavigationController: UINavigationController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.setBackIndicatorImage(UIImage(systemName: "arrowshape.left.circle.fill"), transitionMaskImage: UIImage(systemName: "arrowshape.left.circle.fill"))
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .red
        
//        navigationBar.backIndicatorImage = UIImage(systemName: "arrowshape.left.circle.fill")
//        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrowshape.left.circle.fill")
    }
}

//class CustomNavigationController: UINavigationController {
//    
//    struct AppearanceTheme {
//        let appearanceForegroundColor: UIColor
//        let appearanceBackgroundColor: UIColor?
//        let appearanceFont: UIFont
//        let appearanceLargeTitleFont: UIFont
//
//        static let `default`: AppearanceTheme = AppearanceTheme(
//            appearanceForegroundColor: .label,
//            appearanceBackgroundColor: nil,
//            appearanceFont: UIFont.systemFont(ofSize: 20),
//            appearanceLargeTitleFont: UIFont.systemFont(ofSize: 35)
//        )
//    }
//
//    convenience init(root: UIViewController, theme: AppearanceTheme = .default) {
//        self.init(rootViewController: root)
//        self.setupAppearance(with: theme)
////        self.setupGesture()
//    }
//
//    func setupAppearance(with theme: AppearanceTheme) {
//        self.navigationBar.tintColor = .red
//        navigationItem.largeTitleDisplayMode = .never
//        
//        let attributes: [NSAttributedString.Key : Any] = [
//            NSAttributedString.Key.foregroundColor: theme.appearanceForegroundColor,
//            NSAttributedString.Key.font: theme.appearanceFont
//        ]
//        let largeTitleAttributes: [NSAttributedString.Key : Any] = [
//            NSAttributedString.Key.foregroundColor: theme.appearanceForegroundColor,
//            NSAttributedString.Key.font: theme.appearanceLargeTitleFont
//        ]
//        let appearance = UINavigationBarAppearance()
//        
//        let backButtonImage = UIImage(systemName: "arrow.backward.circle.fill")
//        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
////        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
//        
//        appearance.titleTextAttributes = attributes
//        appearance.backgroundColor = .white
//        appearance.backButtonAppearance.normal.titleTextAttributes = attributes
//        appearance.largeTitleTextAttributes = largeTitleAttributes
//        self.navigationBar.standardAppearance = appearance
//        self.navigationBar.compactAppearance = appearance
//        UINavigationBar.appearance().tintColor = .red
//    }
//    
////    private func setupGesture() {
////        interactivePopGestureRecognizer?.delegate = self
////        switch Language.isRTL() {
////        case true:
////            self.view.semanticContentAttribute = .forceRightToLeft
////        case false:
////            self.view.semanticContentAttribute = .forceLeftToRight
////        }
////    }
//    
//    //MARK: - Deinit -
//    deinit {
//        print("Custom Navigation Controller is deinit, No memory leak found")
//    }
//}
//
