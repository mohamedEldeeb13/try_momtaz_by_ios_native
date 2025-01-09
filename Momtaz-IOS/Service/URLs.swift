//
//  URLs.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 16/12/2024.
//

import Foundation

class URLs {
    static let shared = URLs()
    private init(){}
    
    
    let baseURL = "https://dev.getmomtaz.com/"
    private let baseImageURL = "https://dev.getmomtaz.com/storage/"
    private var endPoint = ""
    
    //MARK: prepare image or video or pdf url
    func  getPhotoOrVideoOrPdfURL(path: String) -> String{
        return baseImageURL + path
        
    }
    
    //MARK: Authentication urls
    func getLoginURL() -> String {
        return baseURL + "api/auth/login"
    }
    
    func getSignUpURL() -> String {
        return baseURL + "api/auth/register"
    }
    
    
    //MARK: workAgenda urls
    func getLessonsDayURL(day:String?) -> String {
        return day == nil || day == "" ? baseURL + "api/schedule/list-by-day" : baseURL + "api/schedule/list-by-day?date=\(day!)"
    }
    
    func getCancelLessonUrl(sessionId: String) -> String {
        return baseURL + "api/schedule/cancel-session/\(sessionId)"
    }
    
    //MARK: reports page
    func addLessonReport() -> String {
        return baseURL + "api/reports/add"
    }
}
