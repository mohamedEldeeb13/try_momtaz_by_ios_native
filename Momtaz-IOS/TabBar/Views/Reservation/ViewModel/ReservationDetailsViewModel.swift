//
//  ReservationDetailsViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 22/01/2025.
//

import Foundation
import UIKit
class ReservationDetailsViewModel {
    
    //MARK: delete session enum
    enum deleteBookingStates {
            case showHud
            case hideHud
            case success
            case failure(String) // Pass the error message
        }
    
    //MARK: closures
    var bindPrepareTeacherBookingDataToViewController: (()->()) = {}
    var bindDeleteBookingResultToViewController: ((deleteBookingStates)->Void)?
    
    //MARK: varaibles
    var teacherBookingDetails: BookingDetails! {
        didSet{
            self.bindPrepareTeacherBookingDataToViewController()
        }
    }
    
    
    //MARK: cancel session function
    func deleteBooking(){
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            bindDeleteBookingResultToViewController?(.failure(Constants.noInternetConnection))
            return
        }
        // get url
        let cancelBookingUrl = URLs.shared.getCancelTeacherBookingUrl(bookingId: String(teacherBookingDetails.id!))
        
        // show progressHud
        bindDeleteBookingResultToViewController?(.showHud)
        NetworkManager.shared.getData(url: cancelBookingUrl){ [weak self] (response: DeleteBookingResponse?, error: String?) in
            self?.bindDeleteBookingResultToViewController?(.hideHud)
            guard let self = self else{return}
            if let error = error {
                bindDeleteBookingResultToViewController?(.failure(Constants.failedDeleteBooking))
                return
            }
            guard let response = response else {  bindDeleteBookingResultToViewController?(.failure(Constants.failedDeleteBooking))
                return
            }
            if response.status == "success"{
                bindDeleteBookingResultToViewController?(.success)
            }else{
                bindDeleteBookingResultToViewController?(.failure(Constants.failedDeleteBooking))
            }
        }
    }
    

    //MARK: Computed properties for UI data
        var studentAvatarURL: String? {
            teacherBookingDetails?.student?.avatar ?? ""
        }
        var studentName: String {
            teacherBookingDetails.student?.name ?? "-"
        }
        var parentName: String {
            teacherBookingDetails.parent?.name ?? "-"
        }
        var studentEductionLevel: String {
            teacherBookingDetails.student?.getFormattedStudentLevel() ?? "-"
        }
        var studentEductionSubject: String {
            teacherBookingDetails.subject?.getFormattedSubject() ?? "-"
        }
        var classDate: String {
            return teacherBookingDetails.pkgType == "MONTHLY"
            ? teacherBookingDetails.prepareMonthlyClassDate()
            : teacherBookingDetails.getIndividualClassDayAndTime()
        }
        var classDuration: String {
            teacherBookingDetails.prepareClassDuration()
        }
        var classPrice: String {
            "\(teacherBookingDetails.price!) \(Constants.currency)"
        }
        var location: String {
            teacherBookingDetails?.parent?.location?.getFormattedParentLocation() ?? "-"
        }
    
        // Button states
        var isClassCancelled: Bool {
            teacherBookingDetails?.status == "CANCELLED"
        }
    func isClassFinished(bookingState: String) -> Bool {
            bookingState == "finished"
        }

    // MARK: - Methods to handle button actions
    func callingParent(viewController: UIViewController) {
            if let phoneNumber = teacherBookingDetails?.parent?.phone {
                HelperFunctions.openCallingApp(with: phoneNumber, on: viewController)
            }else{
                Alert.showAlertWithOnlyPositiveButtons(on: viewController, title: Constants.warning, message: Constants.noHavePhoneNumber, buttonTitle: Constants.ok)
            }
        }
        
    func showClassbill(viewController: UIViewController) {
            
        let controller = ClassBillViewController.instantiat(name: .xib)
        controller.pckType = teacherBookingDetails.pkgType
        controller.price = teacherBookingDetails.price
        controller.teacherPrice = teacherBookingDetails.teacherTotal
        controller.numberOfSessions = teacherBookingDetails.packageDetails?.numOfSessions
        controller.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = controller.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
        }
        viewController.present(controller, animated: true, completion: nil)
    }
        
        
    func deleteBooking(viewController: UIViewController) {
        Alert.showAlertWithNegativeAndPositiveButtons(on: viewController, title: Constants.warning, message: Constants.warningMessageToDeleteBooking, positiveButtonTitle: Constants.deletebooking, negativeButtonTitle: Constants.cancel , positiveButtonStyle: .destructive, positiveHandler: { _ in
                self.deleteBooking()
            })
        }
}
