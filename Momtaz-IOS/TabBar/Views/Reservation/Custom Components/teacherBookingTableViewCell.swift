//
//  teacherBookingTableViewCell.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 21/01/2025.
//

import UIKit

class teacherBookingTableViewCell: UITableViewCell {
    
    //MARK: table cell outlets
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var classType: UILabel!
//    @IBOutlet weak var classPrice: UILabel!
//    @IBOutlet weak var showClassDetailsButton: UIButton!
//    @IBOutlet weak var detailsView: UIView!
//    @IBOutlet weak var classHistoryTextLbl: UILabel!
//    @IBOutlet weak var classDurationTextLbl: UILabel!
//    @IBOutlet weak var classHistory: UILabel!
//    @IBOutlet weak var classDuration: UILabel!
//    @IBOutlet weak var studentLevelTextLbl: UILabel!
//    @IBOutlet weak var studentSubjectTextLbl: UILabel!
//    @IBOutlet weak var studentLevel: UILabel!
//    @IBOutlet weak var studentSubject: UILabel!
//    @IBOutlet weak var parentTextLbl: UILabel!
//    @IBOutlet weak var parentName: UILabel!
//    @IBOutlet weak var callButton: UIButton!
//    @IBOutlet weak var studentLocationTextLbl: UILabel!
//    @IBOutlet weak var studentLocation: UILabel!
//    @IBOutlet weak var showClassBillButton: UIButton!
//    @IBOutlet weak var deleteClassButton: UIButton!
    
    // Track the visibility state of the detailsView
    var isDetailsViewVisible: Bool = false
//    private var parentPhoneNumber: String?
//    private var totalPrice: String?
//    private var teacherPrice: String?
//    private var pckType: String?
//    private weak var viewController: UIViewController?
//    weak var delegate: TeacherBookingCellDelegate? // Delegate for handling actions in the parent view controller
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.lightBorder.cgColor
        contentView.layer.borderWidth = 1
        selectionStyle = .none // to remove selected shadow color
        prepareIntailUI()
    }

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.y += 10
            frame.size.height -= 10
            super.frame = frame
        }
    }
    
    //MARK: SetUp cell details
    func setUpCellData(bookingDetails: BookingDetails){
//        prepareWichBuutonWillShow(isCancelledState: isCancelledState, isFinishedState: isFinishedState)
        studentImageView.setImage(from: bookingDetails.student?.avatar ?? "")
        studentName.text = bookingDetails.student?.name ?? ""
        classType.text = bookingDetails.preparePackageType()
//        classPrice.text = bookingDetails.prepareClassPrice()
//        classHistory.text = bookingDetails.getClassDayAndTime()
//        classDuration.text = bookingDetails.prepareClassDuration()
//        studentLevel.text = bookingDetails.student?.getFormattedStudentLevel()
//        studentSubject.text = bookingDetails.subject?.getFormattedSubject()
//        parentName.text = bookingDetails.parent?.name ?? ""
//        studentLocation.text = bookingDetails.parent?.location?.getFormattedParentLocation()
//        
//        // Store the phone number and parent view controller
//        parentPhoneNumber = bookingDetails.parent?.phone
//        pckType = bookingDetails.pkgType
//        totalPrice = bookingDetails.price
//        teacherPrice = bookingDetails.teacherTotal
//        self.viewController = viewController
    }

    //MARK: setUp intai UI
    private func prepareIntailUI(){
        setUpIntailLabelsUI()
    }
    
    private func setUpIntailLabelsUI(){
//        classHistoryTextLbl.text = Constants.classHistory
//        classDurationTextLbl.text = Constants.classDuration
//        studentLevelTextLbl.text = Constants.eductionalLevel
//        studentSubjectTextLbl.text = Constants.subject
//        parentTextLbl.text = Constants.parent
//        studentLocationTextLbl.text = Constants.studentLocation
        studentImageView.changeImageViewStyle(borderColor: .lightBorder , cornerRadius: 10)
    }
//    private func setUpIntailButtonsUI(){
//        // show details view button ui
//        showClassDetailsButton.addTarget(self, action: #selector(showDetailButtonTapped), for: .touchUpInside)
//        
//        // call button ui
//        callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
//        
//        // show bill button ui
//        showClassBillButton.configureButton(title: Constants.showBill, buttonBackgroundColor: .authPurple, haveBorder: false)
//        showClassBillButton.addTarget(self, action: #selector(showBillButtonTapped), for: .touchUpInside)
//        
//        // delete class button ui
//        deleteClassButton.configureButton(title: Constants.deleteClass, titleColor: .textRed, buttonBackgroundColor: .backgroundRed, icon: "multiply.circle", iconColor: .textRed, haveBorder: false)
//        deleteClassButton.addTarget(self, action: #selector(deleteClassButtonTapped), for: .touchUpInside)
//    }
//    
//    //MARK: buttons action functions
//    // Toggle the visibility of the detailsView
//    @objc private func showDetailButtonTapped() {
//        // Toggle visibility
//        isDetailsViewVisible.toggle()
//        detailsView.isHidden = !isDetailsViewVisible
//
//        // Update button appearance
//        showClassDetailsButton.setImage(
//        UIImage(systemName: isDetailsViewVisible ? "arrowtriangle.up.circle" : "arrowtriangle.down.circle"),
//                for: .normal
//        )
//
//        // Notify delegate
//        delegate?.didToggleDetailsVisibility(for: self)
//    }
//    
//    @objc private func callButtonTapped() {
//        guard let parentVC = viewController else {
//            print("Parent view controller not set")
//            return
//        }
//        if let phoneNumber = parentPhoneNumber {
//            HelperFunctions.openCallingApp(with: phoneNumber, on: parentVC)
//        }else{
//            Alert.showAlertWithOnlyPositiveButtons(on: parentVC, title: Constants.warning, message: Constants.noHavePhoneNumber, buttonTitle: Constants.ok)
//        }
//    }
//    @objc private func showBillButtonTapped() {
//        let controller = ClassBillViewController.instantiat(name: .xib)
//        controller.pckType = pckType
//        controller.price = totalPrice
//        controller.teacherPrice = teacherPrice
//        controller.modalPresentationStyle = .pageSheet
//        if #available(iOS 15.0, *) {
//            if let sheet = controller.sheetPresentationController {
//                sheet.detents = [.medium(), .large()]
//                sheet.prefersGrabberVisible = true
//            }
//        }
//        viewController?.present(controller, animated: true, completion: nil)
//       
//    }
//    @objc private func deleteClassButtonTapped() {
//       
//    }
//    
//    //MARK: prepare which button will show
//    private func prepareWichBuutonWillShow(isCancelledState: Bool, isFinishedState: Bool){
//            showClassBillButton.isHidden = isCancelledState
//            deleteClassButton.isHidden = isCancelledState || isFinishedState
//        
//    }
}
//
//protocol TeacherBookingCellDelegate: AnyObject {
//    func didToggleDetailsVisibility(for cell: teacherBookingTableViewCell)
//}
