//
//  UserDefaults.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 16/12/2024.
//

import Foundation

final class UserDefaultsManager {
    // Singleton instance
    static let shared = UserDefaultsManager()
    
    private init() {} // Prevent external instantiation
    
    // MARK: - Keys
    private enum Keys: String {
        case accessToken
    }
    
    // MARK: - Setters
    func setAccessToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: Keys.accessToken.rawValue)
    }
    
    // MARK: - Getters
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.accessToken.rawValue)
    }
    
    
    // MARK: - Clear All Data
    func clearAll() {
        let keys = [
            Keys.accessToken.rawValue,
        ]
        
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }
}
