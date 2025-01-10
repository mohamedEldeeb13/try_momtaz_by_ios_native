//
//  ChangeLessonDateResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 10/01/2025.
//

import Foundation

// MARK: - Welcome
struct AvailabileLessonTimePerDayResponse: Codable {
    let status: String?
    let errors: Errors?
    let data: AvailabileLessonTimePerDayData?
}

// MARK: - DataClass
struct AvailabileLessonTimePerDayData: Codable {
    let slots: [AvailabileDaySlot]?
    let availability: Availability?
}

// MARK: - Availability
struct Availability: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let teacherID, sessionTime: Int?
    let sessionTimeUnit: String?
    let breakTime: Int?
    let breakTimeUnit: String?
    let officialOffDays: Int?
    let offDays: [String]?
    
        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case teacherID = "teacher_id"
            case sessionTime = "session_time"
            case sessionTimeUnit = "session_time_unit"
            case breakTime = "break_time"
            case breakTimeUnit = "break_time_unit"
            case officialOffDays = "official_off_days"
            case offDays = "off_days"
        }
}

// MARK: - Slot
struct AvailabileDaySlot: Codable {
    let from, to: String?
    let booked: Bool?
    let startDate, endDate, maxDate: String?
    
    // prepare lesson start and end time
     func prepareSlotTime() -> String{
         return "\(Constants.fromHour) \(self.from ?? "-") \(Constants.toHour) \(self.to ?? "-")"
    }
    
    func prepareStartTime()-> String{
        return DateFormatterHelper.formatStringToDateAndTimeString(self.startDate ?? "")
    }
}

// MARK: - Errors
struct Errors: Codable {
    let startDate: [String]?
}
