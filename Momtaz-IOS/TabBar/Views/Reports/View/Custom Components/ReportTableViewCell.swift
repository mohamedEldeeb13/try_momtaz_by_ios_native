//
//  ReportTableViewCell.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 26/01/2025.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    
    static let id = String(describing: ReportTableViewCell.self)
    var buttonAction: (() -> Void)?
    
    //MARK: cell outlets
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var classHistory: UILabel!
    @IBOutlet weak var addOrShowReportButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderColor = UIColor.lightBorder.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        selectionStyle = .none
        studentImage.changeImageViewStyle(cornerRadius: 10)
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
    
    //MARK: prepare intail cell data
    func setUpCellData(isReported: Bool, student: Student, classHistory: String){
        prepareIntailButtonUI(isReported: isReported)
        studentImage.setImage(from: student.avatar ?? "")
        studentName.text = student.name ?? ""
        self.classHistory.text = classHistory
    }
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    private func prepareIntailButtonUI(isReported: Bool){
        addOrShowReportButton.setTitle(isReported ? Constants.showReview : Constants.addReview, for: .normal)
        addOrShowReportButton.titleLabel?.font = UIFont.systemFont(ofSize: 14 , weight: .semibold)
        addOrShowReportButton.setTitleColor(.lightPurple, for: .normal)
        addOrShowReportButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
