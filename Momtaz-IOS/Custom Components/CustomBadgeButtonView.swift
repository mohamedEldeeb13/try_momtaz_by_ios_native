//
//  CustomBadgeButtonView.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 19/12/2024.
//

import Foundation
import UIKit

class BadgeButton: UIButton {
    private var badgeLabel: UILabel!
    
    var badgeValue: Int = 0 {
        didSet {
            badgeLabel.text = "\(badgeValue)"
            badgeLabel.isHidden = badgeValue == 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBadgeLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBadgeLabel()
    }
    
    private func setupBadgeLabel() {
        badgeLabel = UILabel()
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.backgroundColor = .red
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = true // Initially hidden
        addSubview(badgeLabel)
        
        // Constraints for badge
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            badgeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualTo: badgeLabel.heightAnchor)
        ])
    }
}
