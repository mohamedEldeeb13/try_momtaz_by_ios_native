//
//  LessonResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 27/12/2024.
//

import Foundation

// MARK: - LessonResponse
struct LessonResponse : Codable {
    let status: String?
    let data: LessonData?
}

// MARK: - DataClass
struct LessonData : Codable {
    let sessions: [LessonSessions]?
    let date: String?
    let siteExtra: SiteExtra?
}

// MARK: - Welcome
struct LessonSessions : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, bookingID: Int?
    let transactionID: Int?
    let startDate, endDate, status: String?
    let isReported: Bool?
    let seq: Int?
    let booking: LessonBooking?
    
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
                case booking
    }
}

// MARK: - Booking
struct LessonBooking : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID, parentID, subjectID: Int?
    let startDate: String?
    let packageID, packagePriceID: Int?
    let packageDetails: LessonPackageDetails?
    let status, pkgType, price, subtotal: String?
    let teacherTotal, total: String?
//    let priceDetails: PriceDetails?
    let promocodeID: Int?
    let transactionID: Int?
    let payid, payType: String?
    let teacherLocationID, userLocationID, isSettled: Int?
    let settledAt: String?
    let payoutCount: Int?
    let package: PackageDetails?
    let packagePrice: LessonPackagePriceDetails?
    let slots: [Slot]?
    let parent: Parent?
    let student: Student?
    let students: [Student]?
    let subject: Subject?
    
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
                case package, packagePrice,  slots, parent, student, students, subject
    }
}

// MARK: - LessonPackageDetails
struct LessonPackageDetails : Codable {
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

// MARK: - PackageDetails
struct PackageDetails : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let teacherID: Int?
    let PackageType, title, description: String?
    let numOfStudents: Int?
    let numOfSubscribes: Int?
    
    enum CodingKeys: String, CodingKey {
                case id
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case deletedAt = "deleted_at"
                case teacherID = "teacher_id"
                case PackageType = "pkg_type"
                case title
                case description = "descr"
                case numOfStudents = "num_of_students"
                case numOfSubscribes = "num_of_subscribers"
            }
}

// MARK: - PackagePriceDetails
struct LessonPackagePriceDetails : Codable {
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

// MARK: - Parent
struct Parent : Codable {
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
    let location: Location?
    
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
        case location
    }
}

// MARK: - Location
struct Location : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let userID, countryID, cityID, governmentID: Int?
    let country: Country?
    let city: City?
    let government: Government?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case countryID = "country_id"
        case cityID = "city_id"
        case governmentID = "government_id"
        case country, city, government
    }
}

// MARK: - Country
struct Country : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let name: Title?
    let countryID: Int?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name
        case countryID = "country_id"
        case code
    }
}

// MARK: - City
struct City : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let name: Title?
    let countryID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name
        case countryID = "country_id"
    }
}

// MARK: - Title
struct Title : Codable {
    let ar, en: String?
}

// MARK: - Government
struct Government : Codable {
    let id: Int?
    let createdAt, updatedAt, code: String?
    let name: GovernmentName?
    let countryID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case code, name
        case countryID = "country_id"
    }
}

// MARK: - Name
struct GovernmentName : Codable {
    let ar: String?
}

// MARK: - PriceDetails
struct PriceDetails : Codable {
    let extra: [Extra]?
}

// MARK: - Extra
struct Extra : Codable {
    let extraID: Int?
    let type, name: String?
    let price: Price?
    let valType: String?
    let val, priceAfter: Price?
    let langs: String?
    
    enum CodingKeys: String, CodingKey {
        case extraID = "extra_id"
        case type, name, price
        case valType = "val_type"
        case val
        case priceAfter = "price_after"
        case langs
    }
}

enum Price : Codable {
    case integer(Int)
    case string(String)
}

// MARK: - Slot
struct Slot : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let bookingID, teacherID: Int?
    let sessionID: Int?
    let workDay, fromTime, toTime: String?
    let isReserved: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case bookingID = "booking_id"
        case teacherID = "teacher_id"
        case sessionID = "session_id"
        case workDay = "work_day"
        case fromTime = "from_time"
        case toTime = "to_time"
        case isReserved = "is_reserved"
    }
}

// MARK: - Student
struct Student : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let parentID: Int?
    let name, avatar: String?
    let levelID, clsroom: Int?
    let pivot: LessonPivot?
    let level: Level?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case parentID = "parent_id"
        case name, avatar
        case levelID = "level_id"
        case clsroom, pivot, level
    }
}

// MARK: - Level
struct Level : Codable {
    let id: Int?
    let createdAt, updatedAt, code: String?
    let name: Title?
    let numOfStudents, maxClsrooms: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case code, name
        case numOfStudents = "num_of_students"
        case maxClsrooms = "max_clsrooms"
    }
}

// MARK: - Pivot
struct LessonPivot : Codable {
    let bookingID, studentID: Int?
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case studentID = "student_id"
    }
}

// MARK: - Subject
struct Subject : Codable {
    let id: Int?
    let createdAt, updatedAt: String?
    let color: String?
    let title: Title?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case color, title
    }
}


// MARK: - SiteExtra
struct SiteExtra : Codable {
    let dictTimeUnitsPer: DictTimeUnitsPer?
    let dictDueUnits: DictDueUnits?
    let dictDaysOfWeek: DictDaysOfWeek?
    let dictArabicNum: [String: String]?
    
}

// MARK: - DictDaysOfWeek
struct DictDaysOfWeek : Codable {
    let sat, sun, mon, tue: String?
    let wed, thr, fri: String?
}

// MARK: - DictDueUnits
struct DictDueUnits : Codable {
    let hour, minute: String?
}

// MARK: - DictTimeUnitsPer
struct DictTimeUnitsPer : Codable {
    let month, week: String?
}
