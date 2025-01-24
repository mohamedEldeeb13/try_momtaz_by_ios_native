//
//  TeacherStudentsResponse.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 24/01/2025.
//

import Foundation

// MARK: - TeacherStudentsResponse
struct TeacherStudentsResponse: Codable {
    let status: String?
    let data: TeacherStudentsData?
}

// MARK: - DataClass
struct TeacherStudentsData: Codable {
    let students: [Student]?
    let studentsCount: Int?
    let lastMonthCountRate: LastMonthCountRate?
    
    enum CodingKeys: String, CodingKey {
                case students
                case studentsCount = "students_count"
                case lastMonthCountRate = "last_month_count_rate"
    }
    
}

// MARK: - LastMonthCountRate
struct LastMonthCountRate: Codable {
    let newStudentsThisMonth, newStudentsLastThreeMonths: Int?
    let growthRate: String?
    
    enum CodingKeys: String, CodingKey {
                case newStudentsThisMonth = "new_students_this_month"
                case newStudentsLastThreeMonths = "new_students_last_three_months"
                case growthRate = "growth_rate"
    }
}
