//
//  ReportsViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import UIKit
import ProgressHUD

class ReportsViewController: UIViewController {
    
    //MARK: page outlets
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var subHeadTextLbl: UILabel!
    @IBOutlet weak var noInternetView: NoInternet!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var totalReportsView: UIView!
    @IBOutlet weak var totalReportsTextLbl: UILabel!
    @IBOutlet weak var reportedNumberTextLbl: UILabel!
    @IBOutlet weak var reportedNumber: UILabel!
    @IBOutlet weak var reportedProgressView: UIProgressView!
    @IBOutlet weak var reportedPrecentage: UILabel!
    @IBOutlet weak var notReportedNumberTextLbl: UILabel!
    @IBOutlet weak var notReportedNumber: UILabel!
    @IBOutlet weak var notReportedProgressView: UIProgressView!
    @IBOutlet weak var notReportedPrecentage: UILabel!
    @IBOutlet weak var reportsTableView: UITableView!
    
    //MARK: page inner varaibles
    var internetConnectivity: ConnectivityManager?
    var viewModel: ReportsViewModel?
    //MARK: pge life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setIntailUI()
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
        NotificationCenter.default.addObserver(self, selector: #selector(refreshReportsPage), name: .addReportSuccessfullyFromReportPage, object: nil)
    }
    private func removeNotificationObserver(){
        // Register for the lesson deleted notification
        NotificationCenter.default.removeObserver(self, name: .addReportSuccessfullyFromReportPage, object: nil)
    }
    
    @objc private func refreshReportsPage(){
        viewModel?.fetchReportsFromApi()
    }

}
//MARK: setUp intail ui
extension ReportsViewController {
    
    private func setIntailUI(){
        setUpIntailLabelsUI()
        setUpIntailTotalReportsViewUI()
        setUpTableViewRegister()
        setUpIntailtableViewUI()
        
    }
    private func setUpIntailLabelsUI(){
        headTextLbl.text = Constants.reports
        subHeadTextLbl.text = Constants.reportsPageSubHeadText
    }
    private func setUpIntailTotalReportsViewUI(){
        setUpIntailTotalreportsLabelsUI()
        setUpIntailProgressViewUI()
    }
    private func setUpIntailTotalreportsLabelsUI(){
        totalReportsView.layer.borderColor = UIColor.lightBorder.cgColor
        totalReportsView.layer.borderWidth = 1
        totalReportsView.layer.cornerRadius = 15
        totalReportsView.clipsToBounds = true
        totalReportsTextLbl.text = Constants.totalReports
        reportedNumberTextLbl.text = Constants.hasBeenSent
        notReportedNumberTextLbl.text = Constants.notSent
    }
    private func setUpIntailProgressViewUI(){
        reportedProgressView.progress = 0.0
        notReportedProgressView.progress = 0.0
    }
    private func setUpTableViewRegister(){
        reportsTableView.register(UINib(nibName: ReportTableViewCell.id, bundle: nil), forCellReuseIdentifier: ReportTableViewCell.id)
        
    }
    private func setUpIntailtableViewUI(){
        reportsTableView.rowHeight = 80
        reportsTableView.separatorStyle = .none
        reportsTableView.clipsToBounds = true
        reportsTableView.delegate = self
        reportsTableView.dataSource = self
        
    }
    
    //MARK: internet status function
    func showNoIntenetView(){
        internetConnectivity = ConnectivityManager.connectivityInstance
        if internetConnectivity?.isConnectedToInternet() == true {
            noInternetView.isHidden = true
            detailsView.isHidden = false
        }else {
            noInternetView.isHidden = false
            detailsView.isHidden = true
        }
    }
}

//MARK: setUp intail Data
extension ReportsViewController{
    private func setUpIntailData(){
        notReportedNumber.text = "\(viewModel?.reports?.data?.notSentReportsCount ?? 0) \(Constants.report)"
        reportedNumber.text = "\(viewModel?.reports?.data?.sentReportsCount ?? 0) \(Constants.report)"
        let notReportedRounded = viewModel?.reports?.data?.notSentPercentage!.rounded(.toNearestOrAwayFromZero)
        notReportedPrecentage.text = "\(Int(notReportedRounded ?? 0.0)) %"
        let ReportedRounded = viewModel?.reports?.data?.sentPercentage!.rounded(.toNearestOrAwayFromZero)
        reportedPrecentage.text = "\(Int(ReportedRounded ?? 0.0)) %"
       
        notReportedProgressView.setProgress(Float(Int(notReportedRounded ?? 0.0)) / 100.0, animated: true)
        reportedProgressView.setProgress(Float(Int(ReportedRounded ?? 0.0)) / 100.0, animated: true)
    }
}

//MARK: button action function
extension ReportsViewController {
    private func handleButtonAction(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let controller = AddReviewViewController.instantiat(name: .xib)
            controller.fromReportedPage = true
            controller.reportedSession = viewModel?.reports?.data?.sessions?[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        } else if indexPath.section == 1 {
            let controller = ShowReviewViewController.instantiat(name: .xib)
            controller.knowldgeSubjectValue = String(viewModel?.reports?.data?.reports?[indexPath.row].scientificScore ?? 0)
            controller.studentAbilityValue = String(viewModel?.reports?.data?.reports?[indexPath.row].absorbScore ?? 0)
            controller.studentCommitmentValue = String(viewModel?.reports?.data?.reports?[indexPath.row].commitmentScore ?? 0)
            controller.overAllValue = String(viewModel?.reports?.data?.reports?[indexPath.row].globalScore ?? 0)
            controller.noteValue = viewModel?.reports?.data?.reports?[indexPath.row].note ?? "-"
            controller.modalPresentationStyle = .pageSheet
            if #available(iOS 15.0, *) {
                if let sheet = controller.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true
                }
            }
            present(controller, animated: true, completion: nil)
        }
    }
}

//MARK: tableView functions
extension ReportsViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0
        ? viewModel?.reports?.data?.sessions?.count ?? 0
        : viewModel?.reports?.data?.reports?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.id, for: indexPath) as! ReportTableViewCell
        let notReportedList = viewModel?.reports?.data?.sessions
        let reportedList = viewModel?.reports?.data?.reports
        indexPath.section == 0
        ? cell.setUpCellData(isReported: false, student: notReportedList![indexPath.row].student!, classHistory: notReportedList![indexPath.row].getLessonDayAndTime())
        :  cell.setUpCellData(isReported: true, student: reportedList![indexPath.row].student!, classHistory: reportedList![indexPath.row].session!.getLessonDayAndTime())
        cell.buttonAction = { [weak self] in
            self?.handleButtonAction(indexPath: indexPath)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 30 // Set the height of the header
      }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
                headerView.backgroundColor = .white // Customize the background color of the header

                let headerLabel = UILabel()
        headerLabel.text = section == 0 ? Constants.pendingReports : Constants.currentReports
                headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize the font
                headerLabel.textColor = .label // Customize the text color
                headerLabel.translatesAutoresizingMaskIntoConstraints = false

                headerView.addSubview(headerLabel)

                // Set up constraints for the label
                NSLayoutConstraint.activate([
                    headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                    headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
                    headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
                ])

                return headerView
    }
}
//MARK: prepare binding functions
extension ReportsViewController{
    
    private func allBindingFunctions(){
        intailizeViewModel()
        bindWithViewModel()
        getreports()
    }
    private func intailizeViewModel(){
        viewModel = ReportsViewModel()
    }
    
    private func bindWithViewModel(){
        viewModel?.bindGetReportsToViewController = { [weak self] getStudentsSates in
            guard let self = self else { return }
            switch getStudentsSates {
            case .showHud:
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                ProgressHUD.dismiss()
            case .success:
                setUpIntailData()
                reportsTableView.reloadData()
                reportsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
               
            case .failure(let errorMessage):
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                
            }
        }
    }
    
    private func getreports(){
        viewModel?.fetchReportsFromApi()
    }
}


