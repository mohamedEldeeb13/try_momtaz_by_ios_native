//
//  HelperFunctions.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 01/01/2025.
//

import Foundation

class HelperFunctions {
    static func getStudentLevel(levelName: String, classRoomNumber: String) -> String {
        if levelName == "المرحلة الابتدائيه" || levelName == "Primary" {
            switch classRoomNumber {
            case "1":
                return "First year of primary school"
            case "2":
                return "Second year of primary school"
            case "3":
                return "Third year of primary school"
            case "4":
                return "fourth year of primary school"
            case "5":
                return "fifth year of primary school"
            case "6":
                return "Sixth year of primary school"
            default:
                return "-"
            }
        } else if levelName == "المرحلة الاعدادية" || levelName == "Secondary" {
            switch classRoomNumber {
            case "1":
                return "First year of Secondary school"
            case "2":
                return "Second year of Secondary school"
            case "3":
                return "Third year of Secondary school"
            default:
                return "-"
            }
        } else {
            switch classRoomNumber {
            case "1":
                return "First year of high school"
            case "2":
                return "Second year of high school"
            case "3":
                return "Third year of high school"
            default:
                return "-"
            }
        }
    }
}
