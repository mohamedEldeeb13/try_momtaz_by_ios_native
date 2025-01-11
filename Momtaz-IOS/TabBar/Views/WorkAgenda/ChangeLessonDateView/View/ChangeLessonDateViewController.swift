//
//  ChangeLessonDateViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class ChangeLessonDateViewController: UIViewController {
    
    //MARK: components outlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var availbleDatesTableView: UITableView!
    @IBOutlet weak var noInternetView: NoInternet!
    
    //MARK: varaible that will passed
    var sessionID : Int?
    //MARK: inner varaibles
    var internetConnectivity: ConnectivityManager?
    var viewModel : ChangeLessonDateProtocol = ChangeLessonDateViewModel()
    var bag = DisposeBag()
    var offDays: [String] = []

    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUI()
        allBindingFunctions()
    }
    override func viewWillAppear(_ animated: Bool) {
        showNoIntenetView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? MainNavigationController { navigationController.setLogoInTitleView()
        }
    }
    
    //MARK: setup intail ui
    private func setUpIntailUI(){
        setupDatePicker()
        setupRegisterTabelViewCell()
        setUpTableViewUI()
    }
    // prepare table view cell
    private func setupRegisterTabelViewCell() {
        availbleDatesTableView.register(UINib(nibName: String(describing: DateTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DateTableViewCell.self))
    }
    // intail table view ui
    private func setUpTableViewUI(){
        availbleDatesTableView.rowHeight = 70
        availbleDatesTableView.separatorStyle = .none
        availbleDatesTableView.clipsToBounds = true
    }
    
    
    private func setupDatePicker() {
        // Set date picker mode to date only
        datePicker.datePickerMode = .date
        
        // Set the range: today to one month ahead
        let today = Date()
        let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: 1, to: today)
        datePicker.minimumDate = today
        datePicker.maximumDate = oneMonthFromNow
        
        // set border and corner style
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 20
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor(resource: .lightGrey).cgColor
        datePicker.tintColor = UIColor.lightPurple

        // Add a target for when the user selects a date
        datePicker.addTarget(self, action: #selector(datePickerDateChanged(_:)), for: .valueChanged)
    }
    
    //MARK: internet status function
    func showNoIntenetView(){
        internetConnectivity = ConnectivityManager.connectivityInstance
        if internetConnectivity?.isConnectedToInternet() == true {
            noInternetView.isHidden = true
            availbleDatesTableView.isHidden = false
        }else {
            noInternetView.isHidden = false
            availbleDatesTableView.isHidden = true
        }
    }
    
    //MARK: date picker function of action
    @objc func datePickerDateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        // Check if the short day name is in the offDays list
        if isDateValid(selectedDate) {
            // Show alert that the selected day is invalid
            Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: Constants.invailedSelectedDay, buttonTitle: Constants.ok)
        }
    }
    // Check if a given date's day is off
    private func isDateValid(_ date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"  // This will give the full day name (e.g., "Monday", "Tuesday")
        let selectedDay = formatter.string(from: date)
        let shortDayName = DateFormatterHelper.convertDayToshortName(dayName: selectedDay)
        return offDays.contains(shortDayName)
    }
}

//MARK: all binding functions
extension ChangeLessonDateViewController {
    
    private func allBindingFunctions(){
        bindToViewModel()
        subscribeWithChangeLessonDateStates()
        subscribeWithUpdateLessonDateStates()
        subscribeWithTableView()
        subscribeWithTableViewDidSet()
        subscribeToOffDays()
    }
    
    private func bindToViewModel(){
        datePicker.rx.date.map { date -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }.bind(to: viewModel.input.LessonDayBehavorail).disposed(by: bag)
    }
    
    private func subscribeWithTableView() {
        viewModel.output.lessonDaySlotesPublisher.bind(to: availbleDatesTableView.rx.items(cellIdentifier: String(describing: DateTableViewCell.self), cellType: DateTableViewCell.self)){index, slot, cell in
            cell.setUpCellUI(daySlot: slot)
        }.disposed(by: bag)
        
    }
    
    private func subscribeWithTableViewDidSet(){
        availbleDatesTableView.rx.modelSelected(AvailabileDaySlot.self).subscribe(onNext: { slot in
            
            if !slot.booked! {
                self.viewModel.input.sessionIdBehavorail.accept(self.sessionID!)
                self.viewModel.input.newLessonDateBehavorail.accept(slot.prepareStartTime())
                self.viewModel.updateessonDateAlert(viewController: self)
            }
                
        }).disposed(by: bag)
    }
    
    
    private func subscribeWithChangeLessonDateStates() {
        viewModel.input.changeLessonDateStatesPublisher.subscribe(onNext: {[weak self] changeLessonStates in
            
            guard let self = self else { return }
            
            switch changeLessonStates {
            case .showHud:
                self.view.isUserInteractionEnabled = false
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                self.view.isUserInteractionEnabled = true
                ProgressHUD.dismiss()
            case .success:
                self.noInternetView.isHidden = true
                self.availbleDatesTableView.isHidden = false
            case .failure(let error):
                if error == Constants.noInternetConnection{
                    self.noInternetView.isHidden = false
                    self.availbleDatesTableView.isHidden = true
                }
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: error, buttonTitle: Constants.ok)            }
            
        }).disposed(by: bag)
    }
    
    private func subscribeWithUpdateLessonDateStates() {
        
        viewModel.input.updateLessonDateStatesPublisher.subscribe(onNext: {[weak self] updateLessonDateStates in
            guard let self = self else { return }
            
            switch updateLessonDateStates {
            case .showHud:
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                ProgressHUD.dismiss()
            case .success:
                // pop to the root view
                self.navigationController?.popToRootViewController(animated: true)
                Banner.showSuccessBanner(message: Constants.updateLessonDateSuccessfully)
                // Post a notification to refresh the main agenda
                NotificationCenter.default.post(name: .updateLessonDateSuccessfully, object: nil)
            case .failure(let errorMessage):
                if errorMessage == Constants.noInternetConnection {
                    Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                }else {
                    Banner.showErrorBanner(message: Constants.updateLessonDateFailed)
                }
            }
            
        }).disposed(by: bag)
}

    
    
    private func subscribeToOffDays() {
        viewModel.output.offDaysPublisher
            .subscribe(onNext: { [weak self] offDays in
                guard let self = self else { return }
                self.offDays = offDays
            }).disposed(by: bag)
    }
}
