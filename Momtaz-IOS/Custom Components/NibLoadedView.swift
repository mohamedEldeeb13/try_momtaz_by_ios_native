//
//  NibLoadedView.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 05/12/2024.
//

import UIKit

protocol NibLoadedView {
    static var nibName : String {get}
}

extension NibLoadedView where Self : UIView {
    static var nibName : String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}

extension UIView : NibLoadedView {}
