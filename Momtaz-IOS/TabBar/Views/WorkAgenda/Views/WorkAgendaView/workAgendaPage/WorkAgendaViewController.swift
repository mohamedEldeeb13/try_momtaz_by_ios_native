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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNoIntenetView()
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
        }else {
            noInternetView.isHidden = false
        }
    }
    
    //MARK: prepare Alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            
        let alert = Alert().showAlertWithOnlyPositiveButtons(title: title, msg: message, positiveButtonTitle: Constants.ok) { _ in completion?() }
        present(alert, animated: true)
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
            print("SelectedItem: \(item.id ?? 0)")
                }).disposed(by: bag)
    }
    
    private func subscribeWithWorkAgendaStates(){
        viewModel.input.workAgendaStatePublisher.subscribe(onNext:{ [weak self] workAgendaState in
            guard let self = self else{return}
            switch workAgendaState {
            case .showLoading:
                ProgressHUD.animate("Loading...")
            case .hideLoading:
                ProgressHUD.dismiss()
            case .success:
                sessionsTableView.reloadData()
            case .failure(let error):
                if error == "No internet connection"{
                    self.noInternetView.isHidden = false
                }
                showAlert(title: Constants.warning, message: error)
            }
        }).disposed(by: bag)
    }
    
    private func subscribeWithsessionsPublisher() { viewModel.output.sessionsPublisher.subscribe(onNext: { [weak self] sessions in 
        guard let self = self else { return }
        self.noLessonsView.isHidden = !sessions.isEmpty
        self.sessionsTableView.isHidden = sessions.isEmpty
    }).disposed(by: bag)
    }

}
