//
//  StudentsViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 24/01/2025.
//

import Foundation

//MARK: Fetch Students States enum
enum FetchStudentsStates {
        case showHud
        case hideHud
        case success
        case failure(String) // Pass the error message
}

class StudentsViewModel {
    
    var bindGetTeacherStudentsToViewController: ((FetchStudentsStates)-> Void)?
    
    var students: TeacherStudentsResponse?{
        didSet{
            self.bindGetTeacherStudentsToViewController?(.success)
        }
    }
    
    //MARK: fetch lesson function
    func fetchStudentsFromApi() {
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.bindGetTeacherStudentsToViewController?(.failure(Constants.noInternetConnection))
            return
        }
        self.bindGetTeacherStudentsToViewController?(.showHud)
        
        let teacherStudentsURL = URLs.shared.getTeacherStudents()
        
        NetworkManager.shared.getData(url: teacherStudentsURL){ [weak self] (response: TeacherStudentsResponse?, error: String?) in
            guard let self = self else{return}
            self.bindGetTeacherStudentsToViewController?(.hideHud)
            if let error = error {
                self.bindGetTeacherStudentsToViewController?(.failure(error))
                return
            }
            guard let response = response else {
                self.bindGetTeacherStudentsToViewController?(.failure("Failed to fetch data"))
                return
            }
            DispatchQueue.main.async {
                self.students = response
                self.bindGetTeacherStudentsToViewController?(.success)
            }
        }
    }
}
