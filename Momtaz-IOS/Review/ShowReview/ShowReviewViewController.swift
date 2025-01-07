//
//  ShowReviewViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit

class ShowReviewViewController: UIViewController {

    //MARK: components outlet
    @IBOutlet weak var knowledgeOfSubjectLabel: UILabel!
    @IBOutlet weak var comprehensionAbilityLabel: UILabel!
    @IBOutlet weak var studentCommitmentLabel: UILabel!
    @IBOutlet weak var ovelallLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    //MARK: varaible that will passed
    var studentReport: LessonReport!
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

       setupIntailData(report: studentReport)
    }


    private func setupIntailData(report: LessonReport){
        knowledgeOfSubjectLabel.text = String(report.scientificScore ?? 0)
        comprehensionAbilityLabel.text = String(report.absorbScore ?? 0)
        studentCommitmentLabel.text = String(report.commitmentScore ?? 0)
        ovelallLabel.text = String(report.globalScore ?? 0)
        noteLabel.text = report.note ?? "-"
        
    }
}
