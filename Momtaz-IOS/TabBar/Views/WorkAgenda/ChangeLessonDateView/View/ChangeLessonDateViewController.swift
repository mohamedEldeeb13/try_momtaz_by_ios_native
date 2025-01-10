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
    var isSelectedToBooked: [Int: Bool] = [:]
    var selectedStartDate: String?

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
        // chack if date valid or not
        if isDateDisabled(selectedDate) {
            // change date to nearest valid date
            sender.setDate(findNextValidDate(from: selectedDate), animated: true)
            // Show alert or reset to a valid date
            Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: Constants.invailedSelectedDay , buttonTitle: Constants.ok)
        } else {
            // Reset selection state
            isSelectedToBooked.removeAll()
            selectedStartDate = nil
            // Clear previous selection
            availbleDatesTableView.reloadData()
            print("Selected date: \(selectedDate)")
        }
    }
    
    func isDateDisabled(_ date: Date) -> Bool {
        // get current day
        let calendar = Calendar.current
        // get number of current day like 1 or 2 .... from 7
        let weekday = calendar.component(.weekday, from: date)
        // 1 = Sunday, 2 = Monday, 3 = tuseday, 4 = wendsday, 5= thursday, 6= friday, 7 = sturday
        return weekday == 6 || weekday == 4
    }
    
    // to change date to the nearst valide date
    func findNextValidDate(from selectedDate: Date) -> Date {
        // take selected date
        var nextDate = selectedDate
        // make looping to chack if next date is valid or not valid if valid return date and if not valid add one day to currend day
        while isDateDisabled(nextDate) {
            nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextDate)!
        }
        return nextDate
    }
    // New method to handle item selection
    func onDateItemSelected(itemId: Int) {
        isSelectedToBooked[itemId] = true
        for key in isSelectedToBooked.keys {
            if key != itemId {
                isSelectedToBooked[key] = false
            }
        }
    }
}

//MARK: all binding functions
extension ChangeLessonDateViewController {
    
    private func allBindingFunctions(){
        bindToViewModel()
        subscribeWithChangeLessonDateStates()
        subscribeWithTableView()
        subscribeWithTableViewDidSet()
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
                
                if let indexPath = self.availbleDatesTableView.indexPathForSelectedRow,
                    let cell = self.availbleDatesTableView.cellForRow(at: indexPath) as? DateTableViewCell {
                    
                        self.onDateItemSelected(itemId: indexPath.row)
                        cell.layer.borderColor = UIColor.lightPurple.cgColor
                        cell.layer.borderWidth = 2.0
                        cell.layer.cornerRadius = 15
                        cell.dateLabel.textColor = UIColor.lightPurple
                    
                        // Store the startDate
                        self.selectedStartDate = slot.prepareStartTime()
                    
                }
                
            }
                
        }).disposed(by: bag)
    }
    
    
    private func subscribeWithChangeLessonDateStates() {
        viewModel.input.changeLessonDateStatesPublisher.subscribe(onNext: {[weak self] changeLessonStates in
            
            guard let self = self else { return }
            
            switch changeLessonStates {
            case .showLoading:
                self.view.isUserInteractionEnabled = false
                ProgressHUD.animate(Constants.loading)
            case .hideLoading:
                self.view.isUserInteractionEnabled = true
                ProgressHUD.dismiss()
            case .success(let AvailabileDaySlot):
                isSelectedToBooked.removeAll()
                selectedStartDate = nil
                self.noInternetView.isHidden = true
                self.availbleDatesTableView.isHidden = false
                self.availbleDatesTableView.reloadData()
            case .failure(let error):
                if error == Constants.noInternetConnection{
                    self.noInternetView.isHidden = false
                    self.availbleDatesTableView.isHidden = true
                }
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: error, buttonTitle: Constants.ok)            }
            
        }).disposed(by: bag)
    }
}
