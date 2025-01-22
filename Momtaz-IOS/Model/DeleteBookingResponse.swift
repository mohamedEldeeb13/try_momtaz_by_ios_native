//
//  DeleteBookingResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 22/01/2025.
//

import Foundation

// MARK: - Welcome
struct DeleteBookingResponse: Codable {
    let status: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let bookings: DeleteBookings?
}

// MARK: - Bookings
struct DeleteBookings: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, subjectID: Int?
    let startDate: String?
    let packageID, packagePriceID: Int?
    let packageDetails, status, pkgType, price: String?
    let subtotal, teacherTotal, total, priceDetails: String?
    let promocodeID: Int?
    let transactionID: Int?
    let payid, payType: String?
    let teacherLocationID, userLocationID, isSettled: Int?
    let settledAt: String?
    let payoutCount: Int?
    let teacher: Parent?
    
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
                case priceDetails = "price_details"
                case promocodeID = "promocode_id"
                case transactionID = "transaction_id"
                case payid
                case payType = "pay_type"
                case teacherLocationID = "teacher_location_id"
                case userLocationID = "user_location_id"
                case isSettled = "is_settled"
                case settledAt = "settled_at"
                case payoutCount = "payout_count"
                case teacher
    }
}
