//
//  reservationViewModel.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 21/01/2025.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: Reservation view model protocol
protocol ReservationViewModelProtocol {
    var input : ReservationViewModel.Input {get}
    var output : ReservationViewModel.Output {get}
    func viewDidLoad()
}

//MARK: workAgenda States
enum ReservationStates {
    case showHud
    case hideHud
    case success([BookingDetails])
    case failure(String)
}


//MARK: Reservation view model
class ReservationViewModel : ReservationViewModelProtocol , ViewModel {

    //MARK: input
    class Input {
        var reservationTypeBehavior : BehaviorRelay<String> = .init(value: "onProgress")
        var reservationStatePublisher: PublishSubject<ReservationStates> = .init()
    }
    var input: Input = .init()
    //MARK: output
    class Output {
        var teacherBookingsPublisher : PublishSubject<[BookingDetails]> = .init()
    }
    var output: Output = .init()
    
    func viewDidLoad() {
        filterTeacherBookings()
        fetchTeacherbookingsFromApi()
    }
    
    private var collectedAllTeacherBookingsPublished : PublishSubject<TeacherBookingsResponse> = .init()
    private var bag = DisposeBag()
    
    
    //MARK: fetch teacher bookings function
    private func fetchTeacherbookingsFromApi() {
        // Check for internet connectivity
        guard ConnectivityManager.connectivityInstance.isConnectedToInternet() else {
            self.input.reservationStatePublisher.onNext(.failure(Constants.noInternetConnection))
            return
        }
        self.input.reservationStatePublisher.onNext(.showHud)
        
        let teacherbookingsURL = URLs.shared.getTeacherBookings()
        
        NetworkManager.shared.getData(url: teacherbookingsURL){ [weak self] (response: TeacherBookingsResponse?, error: String?) in
            self?.input.reservationStatePublisher.onNext(.hideHud)
            guard let self = self else{return}
            if let error = error { input.reservationStatePublisher.onNext(.failure(error))
                return
            }
            guard let response = response else { input.reservationStatePublisher.onNext(.failure("Failed to fetch data"))
                return
            }
            DispatchQueue.main.async {
                self.collectedAllTeacherBookingsPublished.onNext(response)
                self.input.reservationStatePublisher.onNext(.success(response.data?.bookings?.onProgress ?? []))
            }
        }
    }
    
    private func filterTeacherBookings(){
        Observable.combineLatest(collectedAllTeacherBookingsPublished, input.reservationTypeBehavior).map { (teacherBookings, bookingsType) in
            switch bookingsType {
            case "onProgress":
                return teacherBookings.data?.bookings?.onProgress
            case "cancelled":
                return teacherBookings.data?.bookings?.cancelled
            case "finished":
                return teacherBookings.data?.bookings?.finished
            default:
                return teacherBookings.data?.bookings?.onProgress
            }
            
        }.map{ $0 ?? [] }.bind(to: output.teacherBookingsPublisher).disposed(by: bag)
    }
}
