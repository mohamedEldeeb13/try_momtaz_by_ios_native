//
//  Utilities.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 01/01/2025.
//

import Foundation

class DateFormatterHelper {
    
    static func convertDateStringToTimeAsLike(_ dateString: String) -> String? {
        // Step 1: Create a DateFormatter to parse the original string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Step 2: Convert the string to a Date object
        if let date = inputFormatter.date(from: dateString) {
            // Step 3: Create a DateFormatter to format the Date object to the desired time string
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            outputFormatter.timeZone = TimeZone.current
            
            // Step 4: Convert the Date object to the desired time string
            let timeString = outputFormatter.string(from: date)
            return timeString
        } else {
            // Return nil if the date string is invalid
            return "-"
        }
    }
}
