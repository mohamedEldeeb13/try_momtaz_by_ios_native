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
        studentImageView.setImage(from: bookingDetails.student?.avatar ?? "")
        studentName.text = bookingDetails.student?.name ?? ""
        classType.text = bookingDetails.preparePackageType()
    }

    //MARK: setUp intai UI
    private func prepareIntailUI(){
        setUpIntailLabelsUI()
    }
    
    private func setUpIntailLabelsUI(){
        studentImageView.changeImageViewStyle(borderColor: .lightBorder , cornerRadius: 10)
    }
}
