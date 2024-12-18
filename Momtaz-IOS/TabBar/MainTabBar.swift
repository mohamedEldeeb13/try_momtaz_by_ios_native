//
//  CustomTabBar.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import Foundation
import UIKit

class MainTabBarViewController : UITabBarController {
    override func viewDidLoad() {
        customizeTabBar()
        createAndAddViewControllers()
    }
    
    // Customize tab bar appearance
       private func customizeTabBar() {
           tabBar.backgroundColor = .systemBackground
           tabBar.tintColor = .lightPurple
           tabBar.unselectedItemTintColor = .darkGrey
       }
    
    private func createAndAddViewControllers() {
        view.backgroundColor = .systemBackground
        let vc1 = UINavigationController(rootViewController: WorkAgendaViewController())
        let vc2 = UINavigationController(rootViewController: ReservationsViewController())
        let vc3 = UINavigationController(rootViewController: ReportsViewController())
        let vc4 = UINavigationController(rootViewController: StudentsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "calendar")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "calendar")
        
        vc2.tabBarItem.image = UIImage(systemName: "checkmark.circle")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "checkmark.circle.fill")
        
        vc3.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "dollarsign.circle.fill")
        
        vc4.tabBarItem.image = UIImage(systemName: "person.2")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.3.fill")
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        simpleAnimation(item)
    }
    func simpleAnimation(_ item : UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval : TimeInterval = 0.5
        let propertryAnmator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertryAnmator.addAnimations({ barItemView.transform = .identity}, delayFactor: timeInterval)
        propertryAnmator.startAnimation()
    }
    
}

