//
//  StudentTableViewCell.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 24/01/2025.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    static let id = String(describing: StudentTableViewCell.self)
    
    //MARK: cell outlets
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var parentTextLbl: UILabel!
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var callParentButton: UIButton!
    @IBOutlet weak var studentEductionalStageTextLbl: UILabel!
    @IBOutlet weak var studentClassRoomTextLbl: UILabel!
    @IBOutlet weak var studentEducationalStage: UILabel!
    @IBOutlet weak var studentClassRoom: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderColor = UIColor.lightBorder.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        selectionStyle = .none
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
    func setUpCellData(studentDetails: Student){
        studentImage.setImage(from: studentDetails.avatar ?? "")
        studentName.text = studentDetails.name ?? ""
        parentName.text = studentDetails.parent?.name ?? ""
        studentEducationalStage.text = studentDetails.getFormattedStudentEstage()
        studentClassRoom.text = studentDetails.getFormattedStudentLevel()
    }

    //MARK: setUp intai UI
    private func prepareIntailUI(){
        setUpIntailLabelsUI()
        setUpIntailImageUI()
        setUpIntailbuttonsUI()
    }
    
    private func setUpIntailLabelsUI(){
        studentEductionalStageTextLbl.text = Constants.eductionalStage
        studentClassRoomTextLbl.text = Constants.classRoom
        parentTextLbl.text = Constants.parent
        
    }
    private func setUpIntailImageUI(){
        studentImage.changeImageViewStyle(borderColor: .lightBorder , cornerRadius: 10)
        
    }
    private func setUpIntailbuttonsUI(){
        // Set the button's image and text
        let phoneImage = UIImage(systemName: "phone")
        callParentButton.setImage(phoneImage, for: .normal)
        callParentButton.setTitle("", for: .normal)
        callParentButton.tintColor = .green // Icon color
    }
    
}
