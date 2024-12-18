//
//  UserResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 16/12/2024.
//

import Foundation

struct LogInResponse : Codable {
    let status: String?
//    let message: String?
//    let errors:  [String: [String]]?
    let user: User?
    let authorization: Authorization?
}

// MARK: - Authorization
struct Authorization : Codable {
    let token, type: String?
}

// MARK: - User
struct User : Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let createdAt, updatedAt, accountType, phone: String?
    let avatar: String?
    let profileSteps: Int?
    let phoneVerificationCode: String?
    let phoneVerified: Bool?
    let phoneVerifiedAt: String?
    let nationalityID: Int?
    let cover: String?
    let isVerified, isActive: Bool?
    let verifiedBy, authProvider, authProviderID, fcmToken: String?
    let gender, legalID: String?
    
    enum CodingKeys: String, CodingKey {
                case id, name, email
                case emailVerifiedAt = "email_verified_at"
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case accountType = "account_type"
                case phone, avatar, profileSteps = "profile_steps"
                case phoneVerificationCode = "phone_verification_code"
                case phoneVerified = "phone_verified"
                case phoneVerifiedAt = "phone_verified_at"
                case nationalityID = "nationality_id"
                case cover, isVerified = "is_verified", isActive = "is_active"
                case verifiedBy = "verified_by"
                case authProvider = "auth_provider"
                case authProviderID = "auth_provider_id"
                case fcmToken = "fcm_token"
                case gender
                case legalID = "legal_id"
            }
}
