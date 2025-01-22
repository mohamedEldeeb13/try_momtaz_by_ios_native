//
//  BookingResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 21/01/2025.
//

import Foundation
// MARK: - Welcome
struct TeacherBookingsResponse: Codable {
    let status: String?
    let data: BookingData?
}

// MARK: - DataClass
struct BookingData: Codable {
    let bookings: TeacherBookings?
}

// MARK: - Bookings
struct TeacherBookings:Codable {
    let onProgress: [BookingDetails]?
    let cancelled: [BookingDetails]?
    let finished: [BookingDetails]?
    
    enum CodingKeys: String, CodingKey {
        case onProgress = "on-progress"
        case cancelled, finished
    }
}

// MARK: - Cancelled
struct BookingDetails: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, subjectID: Int?
    let startDate: String?
    let packageID, packagePriceID: Int?
    let packageDetails: LessonPackageDetails?
    let status: String?
    let pkgType: String?
    let price, subtotal, teacherTotal, total: String?
    //    let priceDetails: CancelledPriceDetails?
    let promocodeID: Int?
    let transactionID: Int?
    let payid: String?
    let payType: String?
    let teacherLocationID, userLocationID, isSettled: Int?
    let settledAt: String?
    let payoutCount: Int?
    let slots: [Slot]?
    let parent: Parent?
    let student: Student?
    let students: [Student]?
    let subject: Subject?
    
    // prepare class type
    func preparePackageType() -> String{
        if self.pkgType == "MONTHLY" {
            return "\(Constants.monthly) - \(String((self.packageDetails?.numOfSessions!)!)) \(Constants.classPerWeek)"
        }else{
            return Constants.oneClass
        }
    }
    // prepare class price
    func prepareClassPrice() -> String{
        let price = self.teacherTotal ?? ""
        return "\(price) \(Constants.currency)"
    }
    // prepare class time
    func prepareClassTime() -> String{
        let startDate = DateFormatterHelper.convertDateStringToTime(self.startDate ?? "")
        return startDate ?? "-"
    }
    // prepare  lesson day
    func prepareClassDay() -> String{
        let startDate = DateFormatterHelper.convertDateToAsNameString(self.startDate ?? "")
        return startDate ?? "-"
    }
    
    func getIndividualClassDayAndTime() -> String{
        return "\(prepareClassDay()) -(\(prepareClassTime()))"
    }
    func prepareMonthlyClassDate() -> String {
        var stringDays = ""
        for day in self.slots ?? [] {
            if let workDay = day.workDay, let fromTime = day.fromTime {
                let today = "\(workDay) \(fromTime)"
                // Append to stringDays with a separator
                stringDays += stringDays.isEmpty ? today : ", \(today)"
            }
        } 
        return stringDays
    }
    // prepare lesson duration
    func prepareClassDuration() -> String {
        guard let number = self.packageDetails?.sessionTime else {
            return Constants.notDurationAvailable
        }
        let durationType = (self.packageDetails?.sessionTimeUnit == "HOUR") ? Constants.hour : Constants.minute
        return "\(number) \(durationType)"
    }
   
    enum CodingKeys: String, CodingKey {
                case id
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case deletedAt = "deleted_at"
                case teacherID = "teacher_id"
                case parentID = "parent_id"
                case subjectID = "subject_id"
                case startDate = "start_date"
                case packageID = "package_id"
                case packagePriceID = "package_price_id"
                case packageDetails = "package_details"
                case status
                case pkgType = "pkg_type"
                case price , subtotal
                case teacherTotal = "teacher_total"
                case total
//                case priceDetails = "price_details"
                case promocodeID = "promocode_id"
                case transactionID = "transaction_id"
                case payid
                case payType = "pay_type"
                case teacherLocationID = "teacher_location_id"
                case userLocationID = "user_location_id"
                case isSettled = "is_settled"
                case settledAt = "settled_at"
                case payoutCount = "payout_count"
                case slots, parent, student, students, subject
    }
}
