//
//  AddReviewViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 09/01/2025.
//

import Foundation
import RxSwift
import RxCocoa


//MARK: add review Protocol
protocol AddReviewProtocol : AnyObject {
    var input : AddReviewViewModel.Input {get}
    var output : AddReviewViewModel.Output {get}
    func validationAndAddReview()
}

//MARK: add review States
enum AddReviewStates {
    case showLoading
    case hideLoading
    case success
    case failure(String)
}

class AddReviewViewModel : AddReviewProtocol , ViewModel {
    
    
    //MARK: Input Class
    class Input{
        let parentIDValue = BehaviorRelay<Int?>(value: nil)
        let studentIDValue = BehaviorRelay<Int?>(value: nil)
        let sessionIDValue = BehaviorRelay<Int?>(value: nil)
        let knowledgeSubjectValue = BehaviorRelay<Int?>(value: nil)
        let studentAbilityValue = BehaviorRelay<Int?>(value: nil)
        let studentCommitmentValue = BehaviorRelay<Int?>(value: nil)
        let overAllValue = BehaviorRelay<Int?>(value: nil)
        let notesTextBehavorail = BehaviorRelay<String?>(value: nil)
        
        var addReviewStatesPublisher : PublishSubject<AddReviewStates> = .init()
    }
    var input: Input = .init()
    
    
    //MARK: OutPut Class
    class Output {}
    var output: Output = .init()
    
    func validationAndAddReview() {
        guard
                let _ = input.parentIDValue.value,
                let _ = input.studentIDValue.value,
                let _ = input.sessionIDValue.value,
                let _ = input.knowledgeSubjectValue.value,
                let _ = input.studentAbilityValue.value,
                let _ = input.studentCommitmentValue.value,
                let _ = input.overAllValue.value,
                let notes = input.notesTextBehavorail.value, !notes.isEmpty else { // Ensure `notes` is not empty
            self.input.addReviewStatesPublisher.onNext(.failure(Constants.addAllStudentReportDetails))
                    return
                }
        
        // If all validations pass, proceed to Add Review
        AddReview()
    }
    
    private func AddReview(){
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.input.addReviewStatesPublisher.onNext(.failure(Constants.noInternetConnection))
            return
        }
        self.input.addReviewStatesPublisher.onNext(.showLoading)
            
        let addReviewURL = URLs.shared.addLessonReport()
        let addReviewParameters: [String: Any] = [
            "parent_id": self.input.parentIDValue.value!,
            "student_id": self.input.studentIDValue.value!,
            "session_id": self.input.sessionIDValue.value!,
            "scientific_score": self.input.knowledgeSubjectValue.value!,
            "absorb_score": self.input.studentAbilityValue.value!,
            "commitment_score": self.input.studentCommitmentValue.value!,
            "global_score": self.input.overAllValue.value!,
            "note": self.input.notesTextBehavorail.value!
        ]
            
            // Alamofire POST request
        NetworkManager.shared.postData(url: addReviewURL, parameters: addReviewParameters) { (response : AddReportResponse?, statusCode) in
            
            self.input.addReviewStatesPublisher.onNext(.hideLoading)
            if let statusCode = statusCode , (200...299).contains(statusCode) {
                if (response?.status == "success") {
                    self.input.addReviewStatesPublisher.onNext(.success)
    //              Complete the stream (no more updates will be sent)
                    self.input.addReviewStatesPublisher.onCompleted()
                }else{
                    self.input.addReviewStatesPublisher.onNext(.failure(Constants.failedToAddStudentReport))
                }
            }else{
                self.input.addReviewStatesPublisher.onNext(.failure(Constants.failedToAddStudentReport))
            }
        }
    }
    
    
}
