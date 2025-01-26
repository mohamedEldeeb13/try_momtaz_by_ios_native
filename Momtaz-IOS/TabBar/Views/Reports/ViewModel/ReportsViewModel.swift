//
//  ReportsViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 26/01/2025.
//

import Foundation
import UIKit

//MARK: Fetch Students States enum
enum FetchReportsStates {
        case showHud
        case hideHud
        case success
        case failure(String) // Pass the error message
}

class ReportsViewModel {
    
    var bindGetReportsToViewController: ((FetchReportsStates)-> Void)?
    
    var reports: ReportsResponse?{
        didSet{
            self.bindGetReportsToViewController?(.success)
        }
    }
    
    //MARK: fetch lesson function
    func fetchReportsFromApi() {
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.bindGetReportsToViewController?(.failure(Constants.noInternetConnection))
            return
        }
        self.bindGetReportsToViewController?(.showHud)
        
        let reportsURL = URLs.shared.getReports()
        
        NetworkManager.shared.getData(url: reportsURL){ [weak self] (response: ReportsResponse?, error: String?) in
            guard let self = self else{return}
            self.bindGetReportsToViewController?(.hideHud)
            if let error = error {
                self.bindGetReportsToViewController?(.failure(error))
                return
            }
            guard let response = response else {
                self.bindGetReportsToViewController?(.failure("Failed to fetch data"))
                return
            }
            DispatchQueue.main.async {
                self.reports = response
                self.bindGetReportsToViewController?(.success)
            }
        }
    }
}
