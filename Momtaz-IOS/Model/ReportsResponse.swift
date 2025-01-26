//
//  ReportsResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 26/01/2025.
//

import Foundation

// MARK: - Welcome
struct ReportsResponse: Codable {
    let status: String?
    let data: ReportsData?
}

// MARK: - DataClass
struct ReportsData: Codable {
    let sessions: [SessionElement]?
    let reports: [Report]?
    let notSentPercentage, sentPercentage: Double?
    let totalReports, sentReportsCount, notSentReportsCount: Int?
}
// MARK: - SessionElement
struct SessionElement: Codable {
    let id: Int?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, bookingID: Int?
    let transactionID: Int?
    let startDate, endDate: String?
    let status: String?
    let isReported: Bool?
    let seq: Int?
    let student: Student?
    let parent: Parent?
    let booking: Booking?
    
    // prepare lesson time
    func prepareLessonTime() -> String{
        let startDate = DateFormatterHelper.convertDateStringToTime(self.startDate ?? "")
        return startDate ?? "-"
    }
    // prepare lesson day
    func prepareLessonDay() -> String{
        let startDate = DateFormatterHelper.convertDateToAsNameString(self.startDate ?? "")
        return startDate ?? "-"
    }
    
    func getLessonDayAndTime() -> String{
        return "\(prepareLessonDay()) -(\(prepareLessonTime()))"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case teacherID = "teacher_id"
        case parentID = "parent_id"
        case bookingID = "booking_id"
        case transactionID = "transaction_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case status
        case isReported = "is_reported"
        case seq
        case student, parent, booking
    }

}

// MARK: - Report
struct Report: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let teacherID, parentID, studentID, sessionID: Int?
    let scientificScore, absorbScore, commitmentScore, globalScore: Int?
    let note: String?
    let session: ReportSession?
    let student: Student?
    let parent: Parent?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case teacherID = "teacher_id"
        case parentID = "parent_id"
        case studentID = "student_id"
        case sessionID = "session_id"
        case scientificScore = "scientific_score"
        case absorbScore = "absorb_score"
        case commitmentScore = "commitment_score"
        case globalScore = "global_score"
        case note, session, student, parent
    }

}

// MARK: - ReportSession
struct ReportSession: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, bookingID: Int?
    let transactionID: Int?
    let startDate, endDate: String?
    let status: String?
    let isReported: Bool?
    let seq: Int?
    let booking: Booking?
    
    // prepare lesson time
    func prepareLessonTime() -> String{
        let startDate = DateFormatterHelper.convertDateStringToTime(self.startDate ?? "")
        return startDate ?? "-"
    }
    // prepare lesson day
    func prepareLessonDay() -> String{
        let startDate = DateFormatterHelper.convertDateToAsNameString(self.startDate ?? "")
        return startDate ?? "-"
    }
    
    func getLessonDayAndTime() -> String{
        return "\(prepareLessonDay()) -(\(prepareLessonTime()))"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case teacherID = "teacher_id"
        case parentID = "parent_id"
        case bookingID = "booking_id"
        case transactionID = "transaction_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case status
        case isReported = "is_reported"
        case seq, booking
    }
}

// MARK: - Booking
struct Booking: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, subjectID: Int?
    let startDate: String?
    let packageID, packagePriceID: Int?
    let packageDetails: ReportPackageDetails?
    let status: String?
    let pkgType: String?
    let price, subtotal, teacherTotal, total: String?
    let promocodeID: Int?
    let transactionID: Int?
    let payid: String?
    let payType: String?
    let teacherLocationID, userLocationID, isSettled: Int?
    let settledAt: String?
    let payoutCount: Int?
    
    // prepare package type
    func preparePackageType() -> String{
        let packageType = self.pkgType == "MONTHLY" ? Constants.monthly : Constants.oneClass
        return packageType
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
    }
}

// MARK: - PackageDetails
struct ReportPackageDetails: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let packageID, sessionTime: Int?
    let sessionTimeUnit, price, currency: String?
    let numOfSessions: Int?
    let numOfSessionsPer: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case packageID = "package_id"
        case sessionTime = "session_time"
        case sessionTimeUnit = "session_time_unit"
        case price, currency
        case numOfSessions = "num_of_sessions"
        case numOfSessionsPer = "num_of_sessions_per"
    }
}
 

