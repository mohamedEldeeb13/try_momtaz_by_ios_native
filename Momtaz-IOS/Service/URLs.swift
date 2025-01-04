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
    private var endPoint = ""
    
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
    
}
