//
//  UpdateLessonDateResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 11/01/2025.
//

import Foundation

// MARK: - Welcome
struct UpdateLessonDateResponse: Codable {
    let status, message: String?
    let data: UpdateLessonDateData?
}

// MARK: - DataClass
struct UpdateLessonDateData: Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, bookingID: Int?
    let transactionID: Int?
    let startDate, endDate, status: String?
    let isReported: Bool?
    let seq: Int?
    
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
    }
}
