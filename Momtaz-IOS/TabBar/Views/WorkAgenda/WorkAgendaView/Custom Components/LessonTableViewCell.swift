//
//  LessonTableViewCell.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 27/12/2024.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lessonDateLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentLocationLabel: UILabel!
    @IBOutlet weak var studentLevelAndSubjectLabel: UILabel!
    @IBOutlet weak var lessonCancelledLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        selectionStyle = .none // to remove selected shadow color
        
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
    
    func setUpCellUI(session: LessonSessions){
        prepareIntailUI(isCancelled: session.status ?? "")
        lessonDateLabel.text = session.prepareLessonStartAndEndDate()
        studentNameLabel.text = session.booking?.student?.name ?? ""
        studentLocationLabel.text = session.booking?.parent?.location?.getFormattedParentLocation()
        studentLevelAndSubjectLabel.text = "\(session.booking?.student?.getFormattedStudentLevel() ?? "") - \(session.booking?.subject?.getFormattedSubject() ?? "")"
    }

    private func prepareIntailUI(isCancelled: String){
        if isCancelled == "CANCELLED" {
            lessonCancelledLabel.isHidden = false
//            lessonDateLabel.textColor = UIColor.red
        }else {
            lessonCancelledLabel.isHidden = true
        }
        
    }
}
