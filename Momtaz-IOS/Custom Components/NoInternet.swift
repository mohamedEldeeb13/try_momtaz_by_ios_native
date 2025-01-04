//
//  NoInternet.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 02/01/2025.
//

import UIKit

class NoInternet: UIView {

    // Image view for displaying the "nointernet" image
       private let imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "noInternet") // Use the image from assets
           imageView.contentMode = .scaleAspectFill // Maintain aspect ratio
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
       // Initializer for programmatic use
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       // Initializer for storyboard or XIB use
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
       
       // Function to set up the custom view
       private func setupView() {
           self.backgroundColor = .white // Optional: Set a background color
           
           // Add the imageView to the custom view
           addSubview(imageView)
           
           // Set up constraints to center the imageView
           NSLayoutConstraint.activate([
               imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5), // Image width is 50% of the parent view
               imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) // Maintain aspect ratio
           ])
       }

}
