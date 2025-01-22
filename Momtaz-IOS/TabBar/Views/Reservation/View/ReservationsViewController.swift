//
//  ReservationsViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class ReservationsViewController: UIViewController {
    
    //MARK: Page Outlets
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var subHeadTextLbl: UILabel!
    @IBOutlet weak var bookingSegment: UISegmentedControl!
    @IBOutlet weak var noInternetView: NoInternet!
    @IBOutlet weak var bookingTableView: UITableView!
    @IBOutlet weak var notHaveBookingView: UIView!
    
    
    //MARK: page varaibles
    private var notHaveBookings: notHavebookings!
    private var internetConnectivity: ConnectivityManager?
    private var viewModel : ReservationViewModelProtocol = ReservationViewModel()
    private var bag = DisposeBag()
    

    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUi()
        allBindingFunctions()
        addNotificationObserver()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        showNoIntenetView()
    }
    
    deinit {
        removeNotificationObserver()
    }
}

//MARK: prepare notification center observable
extension ReservationsViewController {
    private func addNotificationObserver(){
        // Register for the lesson deleted notification
        NotificationCenter.default.addObserver(self, selector: #selector(refreshReservationPage), name: .bookingDeleteSuccessfully, object: nil)
    }
    private func removeNotificationObserver(){
        // Register for the lesson deleted notification
        NotificationCenter.default.removeObserver(self, name: .bookingDeleteSuccessfully, object: nil)
    }
    
    //MARK: refresh page when delete or add review or change date is successfully
    
    @objc private func refreshReservationPage() {
        viewModel.viewDidLoad()
    }
}



//MARK: prepare intail ui
extension ReservationsViewController {
    private func setUpIntailUi(){
        headTextLbl.text = Constants.reservationHeadText
        subHeadTextLbl.text = Constants.reservationSubHeadText
        setUpSegmentUI()
        setUpTableViewUI()
        setupRegisterTabelViewCell()
        setUpNotHaveBookingView()
    }
    private func setUpSegmentUI(){
        // Set the titles for the segments
        bookingSegment.removeAllSegments()
        bookingSegment.insertSegment(withTitle: Constants.onProgress, at: 0, animated: false)
        bookingSegment.insertSegment(withTitle: Constants.cancelled, at: 1, animated: false)
        bookingSegment.insertSegment(withTitle: Constants.finished, at: 2, animated: false)
        // Select the first segment by default
        bookingSegment.selectedSegmentIndex = 0
        // Apply border color and corner radius
        bookingSegment.layer.borderColor = UIColor.lightBorder.cgColor
        bookingSegment.layer.borderWidth = 1
        bookingSegment.layer.cornerRadius = 25
        bookingSegment.clipsToBounds = true
        bookingSegment.layer.masksToBounds = true
        // change selected background color
        bookingSegment.selectedSegmentTintColor = UIColor.authPurple
        // Set text attributes for both normal and selected states
        let textAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.label,
                    .font: UIFont.systemFont(ofSize: 14, weight: .bold),
                ]
        bookingSegment.setTitleTextAttributes(textAttributes, for: .normal)
        bookingSegment.setTitleTextAttributes(textAttributes, for: .selected)
        
        bookingSegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    // segment action
    @objc func segmentValueChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
            case 0:
                print("On Progress selected")
            notHaveBookings.setBookingState(.inProgress)
            case 1:
                print("Cancelled selected")
            notHaveBookings.setBookingState(.canceled)
            case 2:
                print("Finished selected")
            notHaveBookings.setBookingState(.finished)
            default:
                break
        }
    }
    
    // prepare not have booking view
    private func setUpNotHaveBookingView(){
        notHaveBookings = notHavebookings(bookingState: .inProgress)
        notHaveBookings.translatesAutoresizingMaskIntoConstraints = false
        notHaveBookingView.addSubview(notHaveBookings)
        NSLayoutConstraint.activate([
            notHaveBookings.topAnchor.constraint(equalTo: notHaveBookingView.topAnchor),
            notHaveBookings.bottomAnchor.constraint(equalTo: notHaveBookingView.bottomAnchor),
            notHaveBookings.leadingAnchor.constraint(equalTo: notHaveBookingView.leadingAnchor),
            notHaveBookings.trailingAnchor.constraint(equalTo: notHaveBookingView.trailingAnchor)
        
        ])
    }
    func showNoIntenetView(){
        internetConnectivity = ConnectivityManager.connectivityInstance
        if internetConnectivity?.isConnectedToInternet() == true {
            noInternetView.isHidden = true
            notHaveBookingView.isHidden = false
            bookingTableView.isHidden = false
        }else {
            noInternetView.isHidden = false
            bookingTableView.isHidden = true
            notHaveBookingView.isHidden = true
        }
    }
    // intail table view ui
    private func setUpTableViewUI(){
        bookingTableView.rowHeight = 80
        bookingTableView.separatorStyle = .none
        bookingTableView.clipsToBounds = true
    }
    // prepare table view cell
    private func setupRegisterTabelViewCell() {
        bookingTableView.register(UINib(nibName: String(describing: teacherBookingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: teacherBookingTableViewCell.self))
    }
}


//MARK: all binding functions
extension ReservationsViewController{
    private func allBindingFunctions(){
        bindToViewModel()
        subscribeWithReservationStates()
        subscribeWithTableView()
        subscribeWithTableViewDidSet()
        viewModel.viewDidLoad()
        
    }
    
    private func bindToViewModel() {
        bookingSegment.rx.selectedSegmentIndex.map { selectedIndex -> String in
            switch selectedIndex {
            case 0:
                return "onProgress"
            case 1:
                return "cancelled"
            case 2:
                return "finished"
            default:
                return "onProgress"
            }
        }.bind(to: viewModel.input.reservationTypeBehavior).disposed(by: bag)
        bookingTableView.reloadData()
    }
    
    private func subscribeWithTableView() {
        viewModel.output.teacherBookingsPublisher.observe(on: MainScheduler.instance).bind(to: bookingTableView.rx.items(cellIdentifier: String(describing: teacherBookingTableViewCell.self) , cellType: teacherBookingTableViewCell.self)){[weak self] index, bookingDetails, cell in
            guard self != nil else { return }
            cell.setUpCellData(bookingDetails: bookingDetails)
        }.disposed(by: bag)
    }
    private func subscribeWithTableViewDidSet(){
        bookingTableView.rx.modelSelected(BookingDetails.self).subscribe(onNext: { item in
            let controller = ReservationDetailsViewController.instantiat(name: .xib)
            controller.teacherBookingdetails = item
            controller.segmentType = self.bookingSegment.selectedSegmentIndex == 2 ? "finished" : ""
            self.navigationController?.pushViewController(controller, animated: true)
                }).disposed(by: bag)
    }
    
    private func subscribeWithReservationStates(){
        viewModel.input.reservationStatePublisher.subscribe(onNext:{ [weak self] workAgendaState in
            guard let self = self else{return}
            switch workAgendaState {
            case .showHud:
                self.view.isUserInteractionEnabled = false
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                self.view.isUserInteractionEnabled = true
                ProgressHUD.dismiss()
            case .success(let teacherBookings):
                self.notHaveBookingView.isHidden = !teacherBookings.isEmpty
                self.noInternetView.isHidden = true
                self.bookingTableView.isHidden = teacherBookings.isEmpty
                bookingTableView.reloadData()
            case .failure(let error):
                if error == Constants.noInternetConnection{
                    self.noInternetView.isHidden = false
                    self.bookingTableView.isHidden = true
                    self.notHaveBookingView.isHidden = true
                }else{
                    self.noInternetView.isHidden = true
                    self.bookingTableView.isHidden = true
                    self.notHaveBookingView.isHidden = true
                }
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: error, buttonTitle: Constants.ok)
            }
        }).disposed(by: bag)
    }
}
