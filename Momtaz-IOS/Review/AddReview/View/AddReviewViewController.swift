//
//  AddReviewViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class AddReviewViewController: UIViewController {
    
    //MARK: components outlet
    
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var subHeadTextLbl: UILabel!
    @IBOutlet weak var studentDetailsTextLbl: UILabel!
    @IBOutlet weak var studentEvalutionTextLbl: UILabel!
    @IBOutlet weak var knowledgeSubjectTextLbl: UILabel!
    @IBOutlet weak var studentAbilityTextLbl: UILabel!
    @IBOutlet weak var studentCommitmentTextLbl: UILabel!
    @IBOutlet weak var overAlltextLbl: UILabel!
    @IBOutlet weak var generalAssessmentTextLbl: UILabel!
    @IBOutlet weak var noteTextLbl: UILabel!
    
    @IBOutlet weak var studentDetails: StudentDetailsView!
    @IBOutlet var elevationButtons: [UIButton]!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: varaible that will passed
    var LessonSession: LessonSessions!
    
    
    //MARK: inner varaibles
    var selectedButtonIndices: [Int: Int] = [:]
    private let viewModel : AddReviewProtocol = AddReviewViewModel()
    private let bag = DisposeBag()
    
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUI()
        setUpIntailData()
        allBindingFunctions()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? MainNavigationController { navigationController.setLogoInTitleView()
        }
    }
    
    //MARK: setUp intail UI
    private func setUpIntailUI(){
        headTextLbl.text = Constants.addReviewHeadText
        subHeadTextLbl.text = Constants.addReviewSubHeadText
        studentDetailsTextLbl.text = Constants.studentDetails
        studentEvalutionTextLbl.text = Constants.studentEvaluation
        knowledgeSubjectTextLbl.text = Constants.ratingGroup1Title
        studentAbilityTextLbl.text = Constants.ratingGroup2Title
        studentCommitmentTextLbl.text = Constants.ratingGroup3Title
        overAlltextLbl.text = Constants.overAllAssessment
        generalAssessmentTextLbl.text = Constants.ratingGroup4Title
        noteTextLbl.text = Constants.note
        setUpStyleOfButtons()
        setUpNoteTextFieldUI()
        setUpSaveButtonUI()
    }
    
    // buttons ui style
    private func setUpStyleOfButtons() {
        for button in elevationButtons {
            // Set border style
            button.layer.borderColor = UIColor.label.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 15
            // Set font
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            // Set text color
            button.tintColor = .label
            // Set background color
            button.backgroundColor = UIColor.systemBackground
            // Add touch highlight behavior
            button.showsTouchWhenHighlighted = true
            // Add button action
            button.addTarget(self, action: #selector(elevationbuttonsPressed(_:)), for: .touchUpInside)
        }
    }
    // save button ui
    private func setUpSaveButtonUI(){
        saveButton.configureButton(title: Constants.save , buttonBackgroundColor: .authPurple, titleFont: UIFont.systemFont(ofSize: 17 , weight: .semibold), buttonCornerRaduis: 20, haveBorder: false)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    // textfield ui
    private func setUpNoteTextFieldUI(){
        // Set the font size for the actual text
        noteTextField.font = UIFont.systemFont(ofSize: 18 , weight: .medium)
        
        // Set the font size for the placeholder
        let placeholderFont = UIFont.systemFont(ofSize: 14)
        let placeholderAttribue : [NSAttributedString.Key : Any] = [
            .font: placeholderFont
        ]
        noteTextField.attributedPlaceholder = NSAttributedString(string: Constants.addNoteMessage, attributes: placeholderAttribue)
        
        noteTextField.layer.borderColor = UIColor.label.cgColor
        noteTextField.layer.borderWidth = 1
        noteTextField.layer.cornerRadius = 10
        noteTextField.clipsToBounds = true
    }
    
    //MARK: prepare intail Data
    private func setUpIntailData(){
        studentDetails.setUpViewData(studentImage: LessonSession.booking?.student?.avatar ?? "", studentName: LessonSession.booking?.student?.name ?? "", packageType: LessonSession.booking?.preparePackageType() ?? "", lessonDate: LessonSession.getLessonDayAndTime(), lessonDuration: LessonSession.prepareLessonDuration())
    }

}

//MARK: action button functions

extension AddReviewViewController {
    @objc func saveButtonPressed(){
        viewModel.validationAndAddReview()
    }
    
    @objc func elevationbuttonsPressed(_ sender: UIButton) {
        let appApperanceMode = traitCollection.userInterfaceStyle
        
        guard let index = elevationButtons.firstIndex(of: sender) else { return }

        let groupIndex = index / 5
        
        // reset previously selected button
        if let previousIndex = selectedButtonIndices[groupIndex], previousIndex != index {
            elevationButtons[previousIndex].backgroundColor = appApperanceMode == .dark ? .black : .white
            elevationButtons[previousIndex].tintColor = appApperanceMode == .dark ? .white : .black
        }
        // Change current selected button
        sender.backgroundColor = appApperanceMode == .dark ? .white : .black
        sender.tintColor = appApperanceMode == .dark ? .black : .white // Change title color to white
        selectedButtonIndices[groupIndex] = index
        
        // Store the button's title value into the appropriate group variable
            if let buttonTitle = sender.titleLabel?.text , let buttonValue = Int(buttonTitle) {
                switch groupIndex {
                case 0:
                    viewModel.input.knowledgeSubjectValue.accept(buttonValue)
                case 1:
                    viewModel.input.studentAbilityValue.accept(buttonValue)
                case 2:
                    viewModel.input.studentCommitmentValue.accept(buttonValue)
                case 3:
                    viewModel.input.overAllValue.accept(buttonValue)
                default:
                    break
                }
            }
    }
}


//MARK: biniding functions

extension AddReviewViewController {
    private func allBindingFunctions(){
        bindingToViewModel()
        subscribeWithAddReviewStates()
    }
    
    private func bindingToViewModel(){
        viewModel.input.parentIDValue.accept(LessonSession.booking?.parent?.id!)
            viewModel.input.studentIDValue.accept(LessonSession.booking?.student?.id!)
            viewModel.input.sessionIDValue.accept(LessonSession.id!)
            noteTextField.rx.text.orEmpty.bind(to: viewModel.input.notesTextBehavorail).disposed(by: bag)
        
    }
    
    private func subscribeWithAddReviewStates() {
        viewModel.input.addReviewStatesPublisher.subscribe(onNext: {[weak self] addReviewStates in
            
            guard let self = self else { return  }
            
            switch addReviewStates {
            case .showLoading:
                ProgressHUD.animate(Constants.loading)
            case .hideLoading:
                ProgressHUD.dismiss()
            case .success:
                self.navigationController?.popToRootViewController(animated: true)
                Banner.showSuccessBanner(message: Constants.addStudentReportSuccessfully)
                // Post a notification to refresh the main agenda
                NotificationCenter.default.post(name: .addReportSuccessfully, object: nil)
            case .failure(let errorMessage ):
                print("Error: \(errorMessage)")
                if errorMessage == Constants.noInternetConnection || errorMessage == Constants.addAllStudentReportDetails {
                    print(errorMessage)
                    Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                }else {
                    Banner.showErrorBanner(message: errorMessage)
                }
            }
            
        }).disposed(by: bag)
    }
}
