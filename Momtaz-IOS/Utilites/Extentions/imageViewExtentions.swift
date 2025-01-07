//
//  imageViewExtentions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import Foundation
import SDWebImage
extension UIImageView {
    func setImage(from urlPath: String?) {
        if let path = urlPath, let url = URL(string: URLs.shared.getPhotoOrVideoOrPdfURL(path: path)) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "noUserImage"))
        } else {
            self.image = UIImage(named: "noUserImage")
        }
    }
    
    func changeImageViewStyle(borderColor: UIColor = .clear, borderWidth: CGFloat = 1, cornerRadius: CGFloat? = nil) {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadius ?? self.frame.size.width / 2 // Default: circular shape
            self.contentMode = .scaleToFill
        }
}

