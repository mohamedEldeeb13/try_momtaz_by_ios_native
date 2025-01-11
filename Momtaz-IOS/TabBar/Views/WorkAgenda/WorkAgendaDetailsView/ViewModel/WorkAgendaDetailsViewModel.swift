//
//  WorkAgendaDetailsViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit

class WorkAgendaDetailsViewModel {
    
    //MARK: delete session enum
    enum cancelLessonStates {
            case showHud
            case hideHud
            case success
            case failure(String) // Pass the error message
        }
    
    //MARK: closures
    var bindSessionResultToViewController: (()->()) = {}
    var bindCancelSessionResultToViewController: ((cancelLessonStates)->Void)?
    
    //MARK: varaibles
    var session: LessonSessions! {
        didSet{
            self.bindSessionResultToViewController()
        }
    }
    
    
    //MARK: cancel session function
    func cancelSession(){
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            bindCancelSessionResultToViewController?(.failure(Constants.noInternetConnection))
            return
        }
        // get url
        let cancelSessionUrl = URLs.shared.getCancelLessonUrl(sessionId: String(session.id!))
        
        // show progressHud
        bindCancelSessionResultToViewController?(.showHud)
        
        NetworkManager.shared.deleteData(url: cancelSessionUrl) {[weak self] isDeleted, statusCode in
        
            guard let self = self else{ return }
            // hide progressHud
            self.bindCancelSessionResultToViewController?(.hideHud)
            
            if isDeleted {
                DispatchQueue.main.async {
                    self.bindCancelSessionResultToViewController?(.success)
                }
            }else{
                let errorMessage = Constants.failedDeleteLesson
                self.bindCancelSessionResultToViewController?(.failure(errorMessage))
                
            }
        }
    }
    

    //MARK: Computed properties for UI data
        var studentAvatarURL: String? {
            session?.booking?.student?.avatar ?? ""
        }
        var studentName: String {
            session?.booking?.student?.name ?? "-"
        }
        var location: String {
            session?.booking?.parent?.location?.getFormattedParentLocation() ?? "-"
        }
        var level: String {
            session?.booking?.student?.getFormattedStudentLevel() ?? "-"
        }
        var subject: String {
            session?.booking?.subject?.getFormattedSubject() ?? "-"
        }
        var lessonTime: String {
            session?.prepareLessonTime() ?? "-"
        }
        var lessonDate: String {
            session?.prepareLessonDay() ?? "-"
        }
        var parentName: String {
            session?.booking?.parent?.name ?? "-"
        }
        var price: String {
            session?.booking?.packageDetails?.price ?? "-"
        }

        // Button states
        var isLessonCancelled: Bool {
            session?.status == "CANCELLED"
        }
    var isAddOrShowReviewHidden: Bool {
           if isLessonCancelled {
               return true
           }
           let compareDatesResult = DateFormatterHelper.compareCurrentDateWithMyDate(as: session?.startDate ?? "")
           return !compareDatesResult
       }
       var isChangeLessonDateHidden: Bool {
           if isLessonCancelled {
               return true
           }
           let compareDatesResult = DateFormatterHelper.compareCurrentDateWithMyDate(as: session?.startDate ?? "")
           return compareDatesResult
       }
       var isDeleteLessonHidden: Bool {
           isChangeLessonDateHidden
       }
       var addOrShowReviewTitle: String {
           guard let session = session else { return "" }
           let isReported = session.isReported ?? false
           return isReported ? Constants.showReview : Constants.addReview
       }
    
    // MARK: - Methods to handle button actions
    func callingParent(viewController: UIViewController) {
            if let phoneNumber = session.booking?.parent?.phone {
                HelperFunctions.openCallingApp(with: phoneNumber, on: viewController)
            }else{
                
                Alert.showAlertWithOnlyPositiveButtons(on: viewController, title: Constants.warning, message: "Not have phone number to call parent", buttonTitle: Constants.ok)
            }
        }
        
        func messageToParent(viewController: UIViewController) {
            if let phoneNumber = session.booking?.parent?.phone {
                let country = phoneNumber.hasPrefix("010") || phoneNumber.hasPrefix("012") || phoneNumber.hasPrefix("011") || phoneNumber.hasPrefix("015") ? "egypt" : "saudi"
                
                HelperFunctions.openWhatsAppChat(with: phoneNumber, country: country, on: viewController)
            }else{
                // Handle the error
                Alert.showAlertWithOnlyPositiveButtons(on: viewController, title: Constants.warning, message: "Not have phone number to chat with parent", buttonTitle: Constants.ok)
            }
                
        }
        
        func addOrShowReview(viewController: UIViewController) {
            if session.isReported ?? false {
                let controller = ShowReviewViewController.instantiat(name: .xib)
                controller.studentReport = session.report
                controller.modalPresentationStyle = .pageSheet
                if #available(iOS 15.0, *) {
                    if let sheet = controller.sheetPresentationController {
                        sheet.detents = [.medium(), .large()]
                        sheet.prefersGrabberVisible = true
                    }
                }
                viewController.present(controller, animated: true, completion: nil)
            } else {
                let controller = AddReviewViewController.instantiat(name: .xib)
                controller.LessonSession = session
                viewController.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
        func changeDate(viewController: UIViewController) {
            let controller = ChangeLessonDateViewController.instantiat(name: .xib)
            controller.sessionID = session.id!
            viewController.navigationController?.pushViewController(controller, animated: true)
        }
        
    func deleteLesson(viewController: UIViewController) {
        Alert.showAlertWithNegativeAndPositiveButtons(on: viewController, title: Constants.warning, message: Constants.warningMessageToDeleteLesson, positiveButtonTitle: Constants.deleteLesson, negativeButtonTitle: Constants.cancel , positiveButtonStyle: .destructive, positiveHandler: { _ in
                self.cancelSession()
            })
        }
}
