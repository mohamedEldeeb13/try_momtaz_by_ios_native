//
//  ChangeLessonDateViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 10/01/2025.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChangeLessonDateProtocol : AnyObject {
    var input : ChangeLessonDateViewModel.Input {get}
    var output : ChangeLessonDateViewModel.Output {get}
    func updateessonDateAlert(viewController: UIViewController)
    
}

//MARK: change lesson States
enum ChangeLessonDateStates {
    case showHud
    case hideHud
    case success
    case failure(String)
}
//MARK: update States
enum UpdateLessonDateStates {
    case showHud
    case hideHud
    case success
    case failure(String)
}



class ChangeLessonDateViewModel : ChangeLessonDateProtocol , ViewModel {
    
    //MARK: varaibles
    let bag = DisposeBag()
    
    //MARK: Input
    class Input{
        var LessonDayBehavorail : BehaviorRelay<String> = .init(value: "")
        var sessionIdBehavorail : BehaviorRelay<Int?> = .init(value: nil)
        var newLessonDateBehavorail : BehaviorRelay<String> = .init(value: "")
        var changeLessonDateStatesPublisher : PublishSubject<ChangeLessonDateStates> = .init()
        var updateLessonDateStatesPublisher : PublishSubject<UpdateLessonDateStates> = .init()
    }
    var input: Input = .init()
    
    //MARK: Output
    class Output{
        var lessonDaySlotesPublisher : PublishSubject<[AvailabileDaySlot]> = .init()
        var offDaysPublisher: PublishSubject<[String]> = .init()
    }
    var output: Output = .init()
    
    //MARK: init
    init() {
        // call function in init to ensures that the necessary bindings and subscriptions are set up immediately when the view model is created and listen for changed in workAgendaDayBehavior to run fetchAvailableLessonssDatesPerDayFromApi from intail when call class
        subscribeWithLessonDaySlots()
    }
    
    
    //MARK: subscribe with lesson day slots
    private func subscribeWithLessonDaySlots(){
        
        input.LessonDayBehavorail
            .skip(1) // to ignore intail value of workAgendaDayBehavior
            .distinctUntilChanged() // to not run request if workAgendaDayBehavior value not changed
            .subscribe({[weak self] _ in
                guard let self = self else { return }
                self.fetchAvailableLessonssDatesPerDayFromApi()
            }).disposed(by: bag)
        
        
    }
    
    
    //MARK: fetch available lesson day slots
    private func fetchAvailableLessonssDatesPerDayFromApi() {
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.input.changeLessonDateStatesPublisher.onNext(.failure(Constants.noInternetConnection))
            return
        }
        
        self.input.changeLessonDateStatesPublisher.onNext(.showHud)
        
        let availabileDaySlotsURL = URLs.shared.getAvailabileLessonDatesInDay()
        let availabileDaySlotsParameters: [String: Any] = [
            "start_date": self.input.LessonDayBehavorail.value
        ]
        
        
        NetworkManager.shared.postData(url: availabileDaySlotsURL, parameters: availabileDaySlotsParameters) {(response: AvailabileLessonTimePerDayResponse? ,statusCode) in
            self.input.changeLessonDateStatesPublisher.onNext(.hideHud)
            if let statusCode = statusCode , (200...299).contains(statusCode) {
                if let errors = response?.errors {
                    self.input.changeLessonDateStatesPublisher.onNext(.failure(errors.startDate?[0] ?? "have error while fetch availabile dates"))
                    return
                }
                DispatchQueue.main.async {
                    let slots = response?.data?.slots ?? []
                    // Extract off days from the response
                    let offDaysFromApi = response?.data?.availability?.offDays ?? []
                    self.output.offDaysPublisher.onNext(offDaysFromApi) // Publish the off days
                    // Assuming `date` is a property of `AvailabileDaySlot`
                    self.output.lessonDaySlotesPublisher.onNext(slots)
                    self.input.changeLessonDateStatesPublisher.onNext(.success)
                }
            }
        }
    }
    
    //MARK: change lesson date
    func updateessonDateAlert(viewController: UIViewController) {
        Alert.showAlertWithNegativeAndPositiveButtons(on: viewController, title: Constants.warning, message: Constants.warningMessageFromUpdateLessonDate, positiveButtonTitle: Constants.changeLessonDate, negativeButtonTitle: Constants.cancel , positiveButtonStyle: .destructive, positiveHandler: { _ in
            self.updateLesssonDate()
        })
    }
    
    private func updateLesssonDate(){
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.input.updateLessonDateStatesPublisher.onNext(.failure(Constants.noInternetConnection))
            return
        }
        self.input.updateLessonDateStatesPublisher.onNext(.showHud)
        
        let updateDateURL = URLs.shared.getUpdateLessonDateURL()
        let updateDateParameters: [String: Any] = [
            "session_id": self.input.sessionIdBehavorail.value!,
            "start_date": self.input.newLessonDateBehavorail.value
        ]
        
        // Alamofire POST request
        NetworkManager.shared.postData(url: updateDateURL, parameters: updateDateParameters) { (response: UpdateLessonDateResponse?, statusCode) in
            
            self.input.updateLessonDateStatesPublisher.onNext(.hideHud)
            if let statusCode = statusCode , (200...299).contains(statusCode) {
                if response?.status == "success" {
                    self.input.updateLessonDateStatesPublisher.onNext(.success)
                    //              Complete the stream (no more updates will be sent)
                    self.input.updateLessonDateStatesPublisher.onCompleted()
                }else {
                    self.input.updateLessonDateStatesPublisher.onNext(.failure(Constants.updateLessonDateFailed))
                }
            }
        }
    }
}
