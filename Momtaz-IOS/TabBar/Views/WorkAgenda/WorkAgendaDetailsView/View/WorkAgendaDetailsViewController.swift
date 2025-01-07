//
//  WorkAgendaDetailsViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 04/01/2025.
//

import UIKit
import ProgressHUD

class WorkAgendaDetailsViewController: UIViewController {

    //MARK: components outlet
    @IBOutlet weak var lessonCancelledLabel: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addOrShowReviewButton: UIButton!
    @IBOutlet weak var changeLessonDateButton: UIButton!
    @IBOutlet weak var deleteLessonButton: UIButton!
    @IBOutlet weak var callingParentButton: UIButton!
    @IBOutlet weak var chatParentButton: UIButton!
    
//MARK: varaible that will passed
    var session: LessonSessions!
    var viewModel: WorkAgendaDetailsViewModel?
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allBindingFunctions()
        setUpAllIntailUI()
    }
    
    //MARK: setup intail ui
    private func setUpAllIntailUI(){
        setUpImageView()
        setUpButtonsUi()
    }
    // image ui
    private func setUpImageView(){
        studentImage.changeImageViewStyle(borderColor: .darkGrey)
    }
    // buttons ui
    private func setUpButtonsUi(){
        callingParentButton.configureButton(title: "Call Parent", buttonBackgroundColor: .authPurple,haveBorder: false)
        callingParentButton.addTarget(self, action: #selector(callingParentButtonTapped), for: .touchUpInside)
        chatParentButton.configureButton(title: "Message Parent", buttonBackgroundColor: .authPurple,haveBorder: false)
        chatParentButton.addTarget(self, action: #selector(messageToParentButtonTapped), for: .touchUpInside)
        addOrShowReviewButton.configureButton(title: "Review", buttonBackgroundColor: .authPurple,haveBorder: false)
        addOrShowReviewButton.addTarget(self, action: #selector(addOrShowReviewButtonTapped), for: .touchUpInside)
        changeLessonDateButton.configureButton(title: "Change Date", haveBorder: true)
        changeLessonDateButton.addTarget(self, action: #selector(changeDateButtonTapped), for: .touchUpInside)
        deleteLessonButton.configureButton(title: "Delete Lesson", titleColor: .textRed, buttonBackgroundColor: .backgroundRed, icon: "multiply.circle", iconColor: .textRed, haveBorder: false)
        deleteLessonButton.addTarget(self, action: #selector(deleteLessonButtonTapped), for: .touchUpInside)
    }
}

//MARK: buttons action functions
extension WorkAgendaDetailsViewController {
    
    @objc private func callingParentButtonTapped(){
        viewModel?.callingParent(viewController: self)
    }
    @objc private func messageToParentButtonTapped(){
        viewModel?.messageToParent(viewController: self)
    }
    @objc private func addOrShowReviewButtonTapped(){
        viewModel?.addOrShowReview(viewController: self)
    }
    @objc private func changeDateButtonTapped(){
        viewModel?.changeDate(viewController: self)
    }
    @objc private func deleteLessonButtonTapped(){
        viewModel?.deleteLesson(viewController: self)
    }
}

//MARK: binding functions
extension WorkAgendaDetailsViewController {
    private func allBindingFunctions(){
        intailizeViewModel()
        bindWithViewModel()
        getLessonSession()
    }
    private func intailizeViewModel(){
        viewModel = WorkAgendaDetailsViewModel()
    }
    private func bindWithViewModel(){
        viewModel?.bindSessionResultToViewController = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateDetailsData()
            }
        }
        
        viewModel?.bindCancelSessionResultToViewController = {[weak self] deleteLessonResult in
            guard let self = self else { return }
            
            switch deleteLessonResult {
            case .showHud:
                ProgressHUD.animate("Loading...")
            case .hideHud:
                ProgressHUD.dismiss()
            case .success:
                // pop to the previous view
                self.navigationController?.popViewController(animated: true)
                Banner.showSuccessBanner(message: "Lesson Deleted Successfully")
                // Post a notification to refresh the main agenda
                NotificationCenter.default.post(name: .lessonDeletedSuccessfully, object: nil)
            case .failure(let errorMessage):
                if errorMessage == Constants.noInternetConnection {
                    Alert.showAlertWithOnlyPositiveButtons(on: self, title: Constants.warning, message: errorMessage, buttonTitle: Constants.ok)
                }else {
                    Banner.showErrorBanner(message: "Error Deleting Lesson")
                }
            }
            
        }
    }
    private func getLessonSession(){
        viewModel?.session = session
    }
    
    //MARK: update details data
    private func updateDetailsData() {
        if let viewModel = viewModel {
            // Update data
            studentImage.setImage(from: viewModel.studentAvatarURL)
            studentName.text = viewModel.studentName
            locationLabel.text = viewModel.location
            levelLabel.text = viewModel.level
            subjectLabel.text = viewModel.subject
            timeLabel.text = viewModel.lessonTime
            dateLabel.text = viewModel.lessonDate
            parentName.text = viewModel.parentName
            priceLabel.text = viewModel.price
            // Update button states
            lessonCancelledLabel.isHidden = !viewModel.isLessonCancelled
            addOrShowReviewButton.isHidden = viewModel.isAddOrShowReviewHidden
            changeLessonDateButton.isHidden = viewModel.isChangeLessonDateHidden
            deleteLessonButton.isHidden = viewModel.isDeleteLessonHidden
            if !viewModel.isAddOrShowReviewHidden {
                addOrShowReviewButton.setTitle(viewModel.addOrShowReviewTitle, for: .normal)
            }
        }
    }
}
