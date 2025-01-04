//
//  ConnectivityManager.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 02/01/2025.
//

import Foundation
import Reachability

class ConnectivityManager {
    static let connectivityInstance = ConnectivityManager()
    
    var reachability: Reachability? {
        do {
            return try Reachability()
        } catch {
            print("Unable to create Reachability instance")
            return nil
        }
    }
    
    func isConnectedToInternet() -> Bool {
        guard let reachability = reachability else { return false }
        return reachability.connection != .unavailable
    }
    
    private init(){
        do{
            try reachability?.startNotifier()
            
        }catch{
            print("Unable to start notifier")
        }
    }
}
