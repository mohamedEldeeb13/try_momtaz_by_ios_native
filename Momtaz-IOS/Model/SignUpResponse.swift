//
//  SignUpResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import Foundation

struct SignUpResponse : Codable {
    let errors:  [String: [String]]?
    let user: SignUpUser?
    let authorization: SignUpAuthorization?
}


// MARK: - Authorization
struct SignUpAuthorization : Codable {
    let token, type: String?
}

// MARK: - User
struct SignUpUser : Codable {
    let id: Int?
    let name, email: String?
    let createdAt, updatedAt, accountType, phone: String?
    let phoneVerificationCode: Int?
    
    enum CodingKeys: String, CodingKey {
                case id, name, email, phone
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case accountType = "account_type"
                case phoneVerificationCode = "phone_verification_code"
                
            }
}
