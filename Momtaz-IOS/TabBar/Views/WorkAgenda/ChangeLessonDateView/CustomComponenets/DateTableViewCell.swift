//
//  DateTableViewCell.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 10/01/2025.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderColor = UIColor.lightGrey.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
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
    
    func setUpCellUI(daySlot: AvailabileDaySlot){
        dateLabel.text = daySlot.prepareSlotTime()
        if daySlot.booked == true {
            contentView.backgroundColor = UIColor.lightGray
        }
    }

    
//    private func prepareIntailUI(isBooked: Bool){
//        if isBooked == "CANCELLED" {
//            lessonDateLabel.text = Constants.lesssonCancelled
//            lessonCancelledLabel.isHidden = false
////            lessonDateLabel.textColor = UIColor.red
//        }else {
//            lessonCancelledLabel.isHidden = true
//        }
//        
//    }
}
