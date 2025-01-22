//
//  WorkAgendaViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 31/12/2024.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: workAgenda view model protocol
protocol WorkAgendaViewModelProtocol : AnyObject {
    var input : WorkAgendaViewModel.Input {get}
    var output : WorkAgendaViewModel.Output {get}
    
}

//MARK: workAgenda States
enum WorkAgendaStates {
    case showHud
    case hideHud
    case success([LessonSessions])
    case failure(String)
}

//MARK: workAgenda view model
class WorkAgendaViewModel : WorkAgendaViewModelProtocol , ViewModel {
    
    //MARK: varaibles
    let bag = DisposeBag()
    
    //MARK: Input
    class Input {
        var workAgendaDayBehavior: BehaviorRelay<String> = .init(value: "")
        var workAgendaStatePublisher: PublishSubject<WorkAgendaStates> = .init()
    }
    
    //MARK: output
    class Output {
        var sessionsPublisher : PublishSubject<[LessonSessions]> = .init()
    }
    
    var input: Input = .init()
    var output: Output = .init()
    
    init() { 
        // call function in init to ensures that the necessary bindings and subscriptions are set up immediately when the view model is created and listen for changed in workAgendaDayBehavior to run fetchLessonssFromApi from intail when call class
        subscribeWithDayInput()
    }
    
    private func subscribeWithDayInput() {
        input.workAgendaDayBehavior
            .skip(1) // to ignore intail value of workAgendaDayBehavior
            .distinctUntilChanged() // to not run request if workAgendaDayBehavior value not changed
            .subscribe(onNext: { [weak self] _ in
                self?.fetchLessonssFromApi()
        }).disposed(by: bag)
    }
    
    //MARK: fetch lesson function
    private func fetchLessonssFromApi() {
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.input.workAgendaStatePublisher.onNext(.failure(Constants.noInternetConnection))
            return
        }
        self.input.workAgendaStatePublisher.onNext(.showHud)
        
        let loginURL = URLs.shared.getLessonsDayURL(day: input.workAgendaDayBehavior.value)
        
        NetworkManager.shared.getData(url: loginURL){ [weak self] (response: LessonResponse?, error: String?) in
            self?.input.workAgendaStatePublisher.onNext(.hideHud)
            guard let self = self else{return}
            if let error = error { input.workAgendaStatePublisher.onNext(.failure(error))
                return
            }
            guard let response = response else { input.workAgendaStatePublisher.onNext(.failure("Failed to fetch data"))
                return
            }
            DispatchQueue.main.async {
                self.output.sessionsPublisher.onNext(response.data?.sessions ?? [])
                self.input.workAgendaStatePublisher.onNext(.success(response.data?.sessions ?? []))
            }
        }
    }

}
