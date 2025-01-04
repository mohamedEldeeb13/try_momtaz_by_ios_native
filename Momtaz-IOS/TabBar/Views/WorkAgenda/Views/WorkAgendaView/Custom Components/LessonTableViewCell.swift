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
        lessonDateLabel.text = prepareLessonDate(startDate: session.startDate ?? "", endDate: session.endDate ?? "")
        studentNameLabel.text = session.booking?.student?.name ?? ""
        studentLocationLabel.text = prepareStudentLocation(location: (session.booking?.parent?.location)!)
        studentLevelAndSubjectLabel.text = prepareStudentLevelAndSubject(student: (session.booking?.student)!, subject: (session.booking?.subject)!)
    }
    
    private func prepareLessonDate(startDate: String , endDate: String) -> String{
        let startDate = DateFormatterHelper.convertDateStringToTimeAsLike(startDate)
        let endDate = DateFormatterHelper.convertDateStringToTimeAsLike(endDate)
        return "From \(startDate!) To \(endDate!)"
        
    }
    
    private func prepareStudentLocation(location: Location) -> String{
        let country = location.country?.name?.en ?? location.country?.name?.ar ?? "-"
        let city = location.city?.name?.en ?? location.city?.name?.ar ?? "-"
        return "\(country) - \(city)"
    }
    
    private func prepareStudentLevelAndSubject(student: Student , subject: Subject) -> String{
        let subject = subject.title?.en ?? subject.title?.en ?? "-"
        let studentLevel = HelperFunctions.getStudentLevel(levelName: student.level?.name?.en ?? student.level?.name?.ar ?? "", classRoomNumber: String(student.clsroom ?? 0))
        return "\(studentLevel) - \(subject)"
    }
    
    private func prepareIntailUI(isCancelled: String){
        if isCancelled == "CANCELLED" {
            lessonCancelledLabel.isHidden = false
            let attributes: [NSAttributedString.Key: Any] = [
                        .strikethroughStyle: NSUnderlineStyle.double.rawValue,
                        .strikethroughColor: UIColor.red
                    ]
            let attributedString = NSAttributedString(string: lessonDateLabel.text ?? "", attributes: attributes)
                    lessonDateLabel.attributedText = attributedString
            
            
        }else {
            lessonCancelledLabel.isHidden = true
        }
        
    }
}
