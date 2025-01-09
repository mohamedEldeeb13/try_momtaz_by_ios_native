//
//  WorkAgendaViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class WorkAgendaViewController: UIViewController {
    
    //MARK: Page Outlets
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noInternetView: NoInternet!
    @IBOutlet weak var sessionsTableView: UITableView!
    @IBOutlet weak var noLessonsView: NoLessonsToDay!
    
    //MARK: page varaibles
    let viewModel : WorkAgendaViewModelProtocol = WorkAgendaViewModel()
    let bag = DisposeBag()
    var internetConnectivity: ConnectivityManager?
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareIntailUI()
        allBindingFunctions()
        
       addNotificationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNoIntenetView()
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    //MARK: prepare notification center observable
    private func addNotificationObserver(){
        // Register for the lesson deleted notification
        NotificationCenter.default.addObserver(self, selector: #selector(refreshWorkAgenda), name: .lessonDeletedSuccessfully, object: nil)
        
        // Register for the lesson deleted notification
        NotificationCenter.default.addObserver(self, selector: #selector(refreshWorkAgenda), name: .addReportSuccessfully, object: nil)
    }
    private func removeNotificationObserver(){
        // Register for the lesson deleted notification
        NotificationCenter.default.removeObserver(self, name: .lessonDeletedSuccessfully, object: nil)
        
        // Register for the lesson deleted notification
        NotificationCenter.default.removeObserver(self, name: .addReportSuccessfully, object: nil)
    }
    
    //MARK: prepare intail UI
    private func prepareIntailUI(){
        setupDatePickerUI()
        setUpTableViewUI()
        setupRegisterTabelViewCell()
    }
    // intail date picker ui
    private func setupDatePickerUI() {
        dateView.clipsToBounds = true
        dateView.layer.cornerRadius = 20
        dateView.layer.borderWidth = 0.5
        dateView.layer.borderColor = UIColor(resource: .lightGrey).cgColor
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    // intail table view ui
    private func setUpTableViewUI(){
        sessionsTableView.rowHeight = 140
        sessionsTableView.separatorStyle = .none
        sessionsTableView.clipsToBounds = true
    }
    // prepare table view cell
    private func setupRegisterTabelViewCell() {
        sessionsTableView.register(UINib(nibName: String(describing: LessonTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LessonTableViewCell.self))
    }
    
    //MARK: date picker function of action
    @objc func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"  // Set custom date format
        let formattedDate = formatter.string(from: selectedDate)
        print("Selected Date: \(formattedDate)")  // Prints date in dd-MM-yyyy format
        self.dismiss(animated: false) // Automatically close the date picker
        viewModel.input.workAgendaDayBehavior.accept(formattedDate)
        
    }
    
    //MARK: internet status function
    func showNoIntenetView(){
        internetConnectivity = ConnectivityManager.connectivityInstance
        if internetConnectivity?.isConnectedToInternet() == true {
            noInternetView.isHidden = true
            sessionsTableView.isHidden = false
            noLessonsView.isHidden = false
        }else {
            noInternetView.isHidden = false
            sessionsTableView.isHidden = true
            noLessonsView.isHidden = true
        }
    }
    
    //MARK: refresh page when delete or add review or change date is successfully
    
    @objc private func refreshWorkAgenda() {
        // Assuming you want to refresh the data for the same day that was being viewed
            let currentDate = viewModel.input.workAgendaDayBehavior.value
            // Change the value slightly to trigger the fetch
            let newDate = currentDate + " " // Concatenate a space or something small to trigger the update
            viewModel.input.workAgendaDayBehavior.accept(newDate)  // Refresh the main agenda list after a lesson has been deleted

    }
}


//MARK: all binding functions
extension WorkAgendaViewController {
    private func allBindingFunctions(){
        bindToViewModel()
        subscribeWithWorkAgendaStates()
        subscribeWithsessionsPublisher()
        subscribeWithTableView()
        subscribeWithTableViewDidSet()
        
    }
    
    private func bindToViewModel() {
        datePicker.rx.date.map { date -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }.bind(to: viewModel.input.workAgendaDayBehavior).disposed(by: bag)
    }
    
    private func subscribeWithTableView() {
        viewModel.output.sessionsPublisher.bind(to: sessionsTableView.rx.items(cellIdentifier: String(describing: LessonTableViewCell.self) , cellType: LessonTableViewCell.self)){index, session, cell in
            cell.setUpCellUI(session: session)
        }.disposed(by: bag)
        
    }
    
    private func subscribeWithTableViewDidSet(){
        sessionsTableView.rx.modelSelected(LessonSessions.self).subscribe(onNext: { item in
            let controller = WorkAgendaDetailsViewController.instantiat(name: .xib)
            controller.session = item
            self.navigationController?.pushViewController(controller, animated: true)
                }).disposed(by: bag)
    }
    
    private func subscribeWithWorkAgendaStates(){
        viewModel.input.workAgendaStatePublisher.subscribe(onNext:{ [weak self] workAgendaState in
            guard let self = self else{return}
            switch workAgendaState {
            case .showLoading:
                self.view.isUserInteractionEnabled = false
                ProgressHUD.animate("Loading...")
            case .hideLoading:
                self.view.isUserInteractionEnabled = true
                ProgressHUD.dismiss()
            case .success:
                sessionsTableView.reloadData()
            case .failure(let error):
                if error == Constants.noInternetConnection{
                    self.noInternetView.isHidden = false
                    self.sessionsTableView.isHidden = true
                    self.noLessonsView.isHidden = true
                }
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: error, buttonTitle: Constants.ok)
            }
        }).disposed(by: bag)
    }
    // for show no lesson view if session list not have any items
    private func subscribeWithsessionsPublisher() { viewModel.output.sessionsPublisher.subscribe(onNext: { [weak self] sessions in
        guard let self = self else { return }
        self.noLessonsView.isHidden = !sessions.isEmpty
        self.sessionsTableView.isHidden = sessions.isEmpty
        self.noInternetView.isHidden = sessions.isEmpty
    }).disposed(by: bag)
    }

}
