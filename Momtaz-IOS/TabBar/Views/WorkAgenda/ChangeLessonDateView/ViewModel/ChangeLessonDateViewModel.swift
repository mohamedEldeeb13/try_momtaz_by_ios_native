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
    
}

//MARK: Login States
enum ChangeLessonDateStates {
    case showLoading
    case hideLoading
    case success([AvailabileDaySlot])
    case failure(String)
}



class ChangeLessonDateViewModel : ChangeLessonDateProtocol , ViewModel {
    
    //MARK: varaibles
    let bag = DisposeBag()
    
    //MARK: Input
    class Input{
        var LessonDayBehavorail : BehaviorRelay<String> = .init(value: "")
        var changeLessonDateStatesPublisher : PublishSubject<ChangeLessonDateStates> = .init()
    }
    var input: Input = .init()
    
    //MARK: Output
    class Output{
        var lessonDaySlotesPublisher : PublishSubject<[AvailabileDaySlot]> = .init()
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
        
        self.input.changeLessonDateStatesPublisher.onNext(.showLoading)
        
        let availabileDaySlotsURL = URLs.shared.getAvailabileLessonDatesInDay()
        let availabileDaySlotsParameters: [String: Any] = [
            "start_date": self.input.LessonDayBehavorail.value
        ]
        
        
        NetworkManager.shared.postData(url: availabileDaySlotsURL, parameters: availabileDaySlotsParameters) {(response: AvailabileLessonTimePerDayResponse? ,statusCode) in
            self.input.changeLessonDateStatesPublisher.onNext(.hideLoading)
            if let statusCode = statusCode , (200...299).contains(statusCode) {
                if let errors = response?.errors {
                    self.input.changeLessonDateStatesPublisher.onNext(.failure(errors.startDate?[0] ?? "have error while fetch availabile dates"))
                    return
                }
                DispatchQueue.main.async {
                    self.output.lessonDaySlotesPublisher.onNext(response?.data?.slots ?? [])
                    self.input.changeLessonDateStatesPublisher.onNext(.success(response?.data?.slots ?? []))
                }
            }
        }
    }
}
