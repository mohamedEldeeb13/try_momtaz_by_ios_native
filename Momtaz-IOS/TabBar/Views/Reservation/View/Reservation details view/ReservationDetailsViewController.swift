//
//  ReservationDetailsViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 22/01/2025.
//

import UIKit
import ProgressHUD

class ReservationDetailsViewController: UIViewController {
    
    //MARK: page outlets
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentNameTextLbl: UILabel!
    @IBOutlet weak var parentNameTextLbl: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var leveTextLbl: UILabel!
    @IBOutlet weak var subjectTextLbl: UILabel!
    @IBOutlet weak var studentLevel: UILabel!
    @IBOutlet weak var studentSubject: UILabel!
    @IBOutlet weak var classHistoryTextLbl: UILabel!
    @IBOutlet weak var classDurationTextLbl: UILabel!
    @IBOutlet weak var classHistory: UILabel!
    @IBOutlet weak var classDuration: UILabel!
    @IBOutlet weak var classPriceTextLbl: UILabel!
    @IBOutlet weak var locationTextLbl: UILabel!
    @IBOutlet weak var classPrice: UILabel!
    @IBOutlet weak var studentLocation: UILabel!
    @IBOutlet weak var callParentButton: UIButton!
    @IBOutlet weak var showBillButton: UIButton!
    @IBOutlet weak var deleteClassButton: UIButton!
    
    //MARK: page varaibles
    var teacherBookingdetails: BookingDetails!
    var segmentType: String!
    var viewModel: ReservationDetailsViewModel?

    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUI()
        allBindingFunctions()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? MainNavigationController { navigationController.setLogoInTitleView()
        }
    }
    
    //MARK: setUp intail UI
    private func setUpIntailUI(){
        setUpIntailLabelUI()
        setUpIntailImageUI()
        setUpIntailButtonsUI()
    }
    private func setUpIntailLabelUI(){
        studentNameTextLbl.text = Constants.name
        parentNameTextLbl.text = Constants.parent
        leveTextLbl.text = Constants.eductionalLevel
        subjectTextLbl.text = Constants.subject
        classHistoryTextLbl.text = Constants.classHistory
        classDurationTextLbl.text = Constants.classDuration
        classPriceTextLbl.text = Constants.classPrice
        locationTextLbl.text = Constants.studentLocation
    }
    private func setUpIntailImageUI(){
        studentImage.changeImageViewStyle(borderColor: .lightBorder , cornerRadius: 20)
    }
    private func setUpIntailButtonsUI(){
        callParentButton.configureButton(title: Constants.callParent, buttonBackgroundColor: .authPurple,haveBorder: false)
        callParentButton.addTarget(self, action: #selector(callingParentButtonTapped), for: .touchUpInside)
        showBillButton.configureButton(title: Constants.showBill, buttonBackgroundColor: .authPurple,haveBorder: false)
        showBillButton.addTarget(self, action: #selector(showClassBillTapped), for: .touchUpInside)
        deleteClassButton.configureButton(title: Constants.deletebooking, titleColor: .textRed, buttonBackgroundColor: .backgroundRed, icon: "multiply.circle", iconColor: .textRed, haveBorder: false)
        deleteClassButton.addTarget(self, action: #selector(deleteLessonButtonTapped), for: .touchUpInside)
    }
}

//MARK: buttons action functions
extension ReservationDetailsViewController {
    
    @objc private func callingParentButtonTapped(){
        viewModel?.callingParent(viewController: self)
    }
    @objc private func showClassBillTapped(){
        viewModel?.showClassbill(viewController: self)
    }
   
    @objc private func deleteLessonButtonTapped(){
        viewModel?.deleteBooking(viewController: self)
    }
}

//MARK: binding functions
extension ReservationDetailsViewController {
    private func allBindingFunctions(){
        intailizeViewModel()
        bindWithViewModel()
        getTeacherBookingDetails()
    }
    private func intailizeViewModel(){
        viewModel = ReservationDetailsViewModel()
    }
    private func bindWithViewModel(){
        viewModel?.bindPrepareTeacherBookingDataToViewController = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateDetailsData()
            }
        }
        
        viewModel?.bindDeleteBookingResultToViewController = {[weak self] deleteBookingResult in
            guard let self = self else { return }
            
            switch deleteBookingResult {
            case .showHud:
                ProgressHUD.animate(Constants.loading)
            case .hideHud:
                ProgressHUD.dismiss()
            case .success:
                // pop to the previous view
                self.navigationController?.popViewController(animated: true)
                Banner.showSuccessBanner(message: Constants.bookingDeleteSuccessfully)
                // Post a notification to refresh the main agenda
                NotificationCenter.default.post(name: .bookingDeleteSuccessfully, object: nil)
            case .failure(let errorMessage):
                if errorMessage == Constants.noInternetConnection {
                    Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                }else {
                    Banner.showErrorBanner(message: Constants.failedDeleteBooking)
                }
            }
            
        }
    }
    private func getTeacherBookingDetails(){
        viewModel?.teacherBookingDetails = teacherBookingdetails
    }
    
    //MARK: update details data
    private func updateDetailsData() {
        if let viewModel = viewModel {
            // Update data
            studentImage.setImage(from: viewModel.studentAvatarURL)
            studentName.text = viewModel.studentName
            parentName.text = viewModel.parentName
            studentLevel.text = viewModel.studentEductionLevel
            studentSubject.text = viewModel.studentEductionSubject
            classHistory.text = viewModel.classDate
            classDuration.text = viewModel.classDuration
            classPrice.text = viewModel.classPrice
            studentLocation.text = viewModel.location
            classHistoryTextLbl.text = viewModel.teacherBookingDetails.pkgType == "MONTHLY" ? Constants.classHistoryPerWeek : Constants.classHistory
            
            deleteClassButton.isHidden = viewModel.isClassCancelled || viewModel.isClassFinished(bookingState: segmentType)
            showBillButton.isHidden = viewModel.isClassCancelled
            
        }
    }
}


