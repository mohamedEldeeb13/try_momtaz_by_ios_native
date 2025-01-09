//
//  StudentDetailsView.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/01/2025.
//

import UIKit

class StudentDetailsView: UIView {
    
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var packageType: UILabel!
    @IBOutlet weak var lessonDate: UILabel!
    @IBOutlet weak var lessonDuration: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StudentDetailsView", bundle: bundle)
        let contentView = nib.instantiate(withOwner: self , options: nil).first as! UIView
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.lightBorder.cgColor
        contentView.layer.borderWidth = 1
        addSubview(contentView)
        setUpImageView()
    }
    // image ui
    private func setUpImageView(){
        studentImage.changeImageViewStyle(cornerRadius: 10)
    }
    
    func setUpViewData(studentImage: String, studentName: String, packageType: String, lessonDate: String, lessonDuration: String ){
        self.studentImage.setImage(from: studentImage)
        self.studentName.text = studentName
        self.packageType.text = packageType
        self.lessonDate.text = lessonDate
        self.lessonDuration.text = lessonDuration
    }

}
