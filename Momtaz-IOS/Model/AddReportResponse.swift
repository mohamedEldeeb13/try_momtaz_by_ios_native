//
//  AddReportResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 09/01/2025.
//

import Foundation

// MARK: - AddReviewResponse
struct AddReportResponse: Codable {
    let status, message: String?
//    let data: AddReviewData?
    
    enum CodingKeys: String, CodingKey {
        case status, message
//        , data
    }
}
//
//// MARK: - AddReviewData
//struct AddReviewData: Codable {
//    var sessionID: Int?
//        var note: String?
//        var parentID: Int?
//        var teacher: AddReportParent?
//        var parent: AddReportParent?
//        var session: AddReportSession?
//
//        enum CodingKeys: String, CodingKey {
//            case sessionID = "session_id"
//            case note
//            case parentID = "parent_id"
//            case teacher
//            case parent
//            case session
//        }
//}
//
//// MARK: - AddReportSession
//struct AddReportSession: Codable {
//    let id: Int?
//    let createdAt, updatedAt: String?
//    let deletedAt: String?
//    let teacherID, parentID, bookingID: Int?
//    let transactionID: Int?
//    let startDate, endDate, status: String?
//    let isReported: Bool?
//    let seq: Int?
//    let booking: AddReportBooking?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, createdAt = "created_at", updatedAt = "updated_at", deletedAt = "deleted_at"
//        case teacherID = "teacher_id", parentID = "parent_id", bookingID = "booking_id", transactionID = "transaction_id"
//        case startDate = "start_date", endDate = "end_date", status
//        case isReported = "is_reported", seq, booking
//    }
//}
//
//// MARK: - AddReportBooking
//struct AddReportBooking: Codable {
//    let id: Int?
//    let createdAt, updatedAt: String?
//    let deletedAt: String?
//    let teacherID, parentID, subjectID: Int?
//    let startDate: String?
//    let packageID, packagePriceID: Int?
//    let packageDetails, status, pkgType, price: String?
//    let subtotal, teacherTotal, total, priceDetails: String?
//    let promocodeID: Int?
//    let transactionID: Int?
//    let payid, payType: String?
//    let teacherLocationID, userLocationID, isSettled: Int?
//    let settledAt: String?
//    let payoutCount: Int?
//    let subject: Subject?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, createdAt = "created_at", updatedAt = "updated_at", deletedAt = "deleted_at"
//        case teacherID = "teacher_id", parentID = "parent_id", subjectID = "subject_id", startDate = "start_date"
//        case packageID = "package_id", packagePriceID = "package_price_id", packageDetails = "package_details"
//        case status, pkgType = "pkg_type", price, subtotal, teacherTotal = "teacher_total", total
//        case priceDetails = "price_details", promocodeID = "promocode_id", transactionID = "transaction_id"
//        case payid, payType = "pay_type", teacherLocationID = "teacher_location_id", userLocationID = "user_location_id"
//        case isSettled = "is_settled", settledAt = "settled_at", payoutCount = "payout_count", subject
//    }
//}
//
//// MARK: - AddReportParent
//struct AddReportParent: Codable {
//    let id: Int?
//    let name, email: String?
//    let emailVerifiedAt: String?
//    let createdAt, updatedAt, accountType, phone: String?
//    let avatar: String?
//    let profileSteps: Int?
//    let phoneVerificationCode: String?
//    let phoneVerified: Bool?
//    let phoneVerifiedAt: String?
//    let nationalityID: Int?
//    let cover: String?
//    let isVerified, isActive: Bool?
//    let verifiedBy, authProvider, authProviderID, fcmToken: String?
//    let gender, legalID: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, email
//        case emailVerifiedAt = "email_verified_at"
//        case createdAt = "created_at", updatedAt = "updated_at", accountType = "account_type", phone, avatar
//        case profileSteps = "profile_steps", phoneVerificationCode = "phone_verification_code"
//        case phoneVerified = "phone_verified", phoneVerifiedAt = "phone_verified_at", nationalityID = "nationality_id"
//        case cover, isVerified = "is_verified", isActive = "is_active", verifiedBy = "verified_by"
//        case authProvider = "auth_provider", authProviderID = "auth_provider_id", fcmToken = "fcm_token"
//        case gender, legalID = "legal_id"
//    }
//}
//
//// MARK: - AddReportStudent
//struct AddReportStudent: Codable {
//    let id: Int?
//    let createdAt, updatedAt: String?
//    let parentID: Int?
//    let name: String?
//    let avatar: String?
//    let levelID, clsroom: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, createdAt = "created_at", updatedAt = "updated_at", parentID = "parent_id", name, avatar
//        case levelID = "level_id", clsroom
//    }
//}
//
