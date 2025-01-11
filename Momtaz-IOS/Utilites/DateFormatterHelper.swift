//
//  Utilities.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 01/01/2025.
//

import Foundation

class DateFormatterHelper {
    
    //MARK: 12;00 AM
    static func convertDateStringToTime(_ date: String) -> String? {
        // Step 1: Create a DateFormatter to parse the original string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Step 2: Convert the string to a Date object
        if let date = inputFormatter.date(from: date) {
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
    
    //MARK: Sun, 29 Dec 2024
    static func convertDateToAsNameString(_ date: String) -> String? {
        // Input Date Formatter
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Output Date Formatter
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE, dd MMM yyyy"
        outputFormatter.timeZone = TimeZone.current
        
        // Convert to Date
        if let date = inputFormatter.date(from: date) {
            // Convert to Desired Format
            let outputDateString = outputFormatter.string(from: date)
            return outputDateString
        }else {
            return "-"
        }
    }
    //MARK: compare current date with my date to return true id current date after or same my date and return false if before my date
    static func compareCurrentDateWithMyDate(as date: String) -> Bool {
        // Input Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        // Parse the input date string
        if let inputDate = dateFormatter.date(from: date) {
            // Get the current date
            let currentDate = Date()
            // Compare the dates
            return currentDate >= inputDate
        } else {
            print("Invalid date format.")
            return false
        }
    }
    
    //MARK: 2025-01-12 00:00
    static func formatStringToDateAndTimeString(_ dateString: String?) -> String {
        guard let dateString = dateString, !dateString.isEmpty else {
            return "Invalid date"
        }
        
        // Initialize a custom DateFormatter to parse the input string format (ISO 8601 with microseconds)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'" // The exact input format
        
        // Initialize the output formatter to match your desired format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        outputFormatter.locale = Locale(identifier: "en_US")
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date format"
        }
    }
    
    //MARK: convert day from string to complete name
    
    static func convertDayToshortName(dayName: String) -> String {
        switch dayName.lowercased() {
        case "saturday":
            return "sat"
        case "sunday":
            return "sun"
        case "monday":
            return "mon"
        case "tuesday":
            return "tue"
        case "wednesday":
            return "wed"
        case "thursday":
            return "tue"
        case "friday":
            return "fri"
        default:
            return ""
        }
    }
}

