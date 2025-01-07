//
//  RegularExcepression.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation

struct RegularExpression {
    static let saudiArabiaPhone = "^(5[0-9]{8}|05[0-9]{8}|\\+9665[0-9]{8})$"  // Example pattern for Saudi Arabia phone numbers
    static let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]*$"
}
