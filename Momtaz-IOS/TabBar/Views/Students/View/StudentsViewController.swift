//
//  StudentsViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 18/12/2024.
//

import UIKit
import ProgressHUD

class StudentsViewController: UIViewController {
    
    //MARK: page outlets
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var subHeadTextLbl: UILabel!
    @IBOutlet weak var totalStudentsView: UIView!
    @IBOutlet weak var totalStudentsTextLbl: UILabel!
    @IBOutlet weak var totalStudents: UILabel!
    @IBOutlet weak var newStudentsView: UIView!
    @IBOutlet weak var newStudentsTextLbl: UILabel!
    @IBOutlet weak var newStudents: UILabel!
    @IBOutlet weak var teacherStudentsTableView: UITableView!
    @IBOutlet weak var noInternetView: NoInternet!
    @IBOutlet weak var noStudentsView: UIView!
    @IBOutlet weak var noStudentstextLbl: UILabel!
    @IBOutlet weak var notHaveStudentsImage: UIImageView!
    @IBOutlet weak var studentDetailsView: UIView!
    
    
    //MARK: page inner varaibles
    var internetConnectivity: ConnectivityManager?
    var viewModel: StudentsViewModel?
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUI()
        allBindingFunctions()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        showNoIntenetView()
    }
    //MARK: prepare intail data
}

//MARK: setUp intail outlets ui
extension StudentsViewController{
    private func setUpIntailUI(){
        setUpIntailLabelsUI()
        setUpIntailGeneralNumberViewsUI()
        setUpTableViewRegister()
        setUpIntailTableViewUI()
    }
    private func setUpIntailLabelsUI(){
        headTextLbl.text = Constants.yourStudents
        subHeadTextLbl.text = Constants.StudentsPageSubHeadText
        totalStudentsTextLbl.text = Constants.totalStudentsNumber
        newStudentsTextLbl.text = Constants.newStudents
        noStudentstextLbl.text = Constants.notHaveStudents
        notHaveStudentsImage.image = UIImage(named: "notHaveBookingImage")
    }
    private func setUpIntailGeneralNumberViewsUI(){
        // setup total students view ui
        totalStudentsView.layer.borderColor = UIColor.lightBorder.cgColor
        totalStudentsView.layer.borderWidth = 1
        totalStudentsView.layer.cornerRadius = 15
        totalStudentsView.clipsToBounds = true
        // setup new students view ui
        newStudentsView.layer.borderColor = UIColor.lightBorder.cgColor
        newStudentsView.layer.borderWidth = 1
        newStudentsView.layer.cornerRadius = 15
        newStudentsView.clipsToBounds = true
    }
    private func setUpTableViewRegister(){
        teacherStudentsTableView.register(UINib(nibName: StudentTableViewCell.id, bundle: nil), forCellReuseIdentifier: StudentTableViewCell.id)
        
    }
    private func setUpIntailTableViewUI(){
        teacherStudentsTableView.estimatedRowHeight = 120
        teacherStudentsTableView.delegate = self
        teacherStudentsTableView.dataSource = self
        
        
    }
    
    func showNoIntenetView(){
        internetConnectivity = ConnectivityManager.connectivityInstance
        let isConnected = internetConnectivity?.isConnectedToInternet() ?? false
            noInternetView.isHidden = isConnected
            noStudentsView.isHidden = !isConnected
            studentDetailsView.isHidden = !isConnected
    }
}

//MARK: prepare table view
extension StudentsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.students?.data?.students?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.id, for: indexPath) as! StudentTableViewCell
        if let student = viewModel?.students?.data?.students?[indexPath.row] {
            cell.setUpCellData(studentDetails: student)
            totalStudents.text = "\(viewModel?.students?.data?.studentsCount ?? 0) \(Constants.student)"
            newStudents.text = "\(viewModel?.students?.data?.lastMonthCountRate?.newStudentsThisMonth ?? 0) \(Constants.student)"
            cell.callParentButton.addTarget(self, action: #selector(callParentButtonTapped(_:)), for: .touchUpInside)
        }
        return cell
    }
}

//MARK: call button tapped function
extension StudentsViewController {
    //Handle Button Action
       @objc func callParentButtonTapped(_ sender: UIButton) {
           let rowIndex = sender.tag
           guard let student = viewModel?.students?.data?.students?[rowIndex] else { return }
           let phone = student.parent?.phone // Assuming `parent.phone` contains the phone number
           callingParent(phone: phone)
       }
    @objc func callingParent(phone: String?) {
        if let phoneNumber = phone {
                HelperFunctions.openCallingApp(with: phoneNumber, on: self)
            }else{
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: Constants.noHavePhoneNumber, buttonTitle: Constants.ok)
            }
        }
}

//MARK: prepare binding functions
extension StudentsViewController{
    
    private func allBindingFunctions(){
        bindWithViewModel()
        getTeacherStudents()
    }
    
    private func bindWithViewModel(){
        viewModel = StudentsViewModel()
        viewModel?.bindGetTeacherStudentsToViewController = { [weak self] getStudentsSates in
            guard let self = self else { return }
            switch getStudentsSates {
            case .showHud:
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                ProgressHUD.dismiss()
            case .success:
                if let students = viewModel?.students?.data?.students, !students.isEmpty {
                    // Students are available
                    noStudentsView.isHidden = true
                    studentDetailsView.isHidden = false
                    DispatchQueue.main.async {
                        self.teacherStudentsTableView.reloadData()
                    }
                } else {
                    // No students available
                    noStudentsView.isHidden = false
                    studentDetailsView.isHidden = true
                }
            case .failure(let errorMessage):
                Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                
            }
        }
    }
    
    private func getTeacherStudents(){
        viewModel?.fetchStudentsFromApi()
    }
}

