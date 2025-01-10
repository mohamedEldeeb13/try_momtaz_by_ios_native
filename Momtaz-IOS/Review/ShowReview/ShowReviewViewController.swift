//
//  ShowReviewViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 06/01/2025.
//

import UIKit

class ShowReviewViewController: UIViewController {

    //MARK: components outlet
    
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var knowldgeSubjectTextLbl: UILabel!
    @IBOutlet weak var studentAbilityTextLbl: UILabel!
    @IBOutlet weak var studentCommitmentTextLbl: UILabel!
    @IBOutlet weak var overAllTextLbl: UILabel!
    @IBOutlet weak var noteTextLbl: UILabel!
    
    
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
        setUpIntailUI()
       setupIntailData(report: studentReport)
    }
    
    private func setUpIntailUI(){
        headTextLbl.text = Constants.showReviewHeadText
        knowldgeSubjectTextLbl.text = Constants.knowledgeOfSubject
        studentAbilityTextLbl.text = Constants.studentComprehensionAbility
        studentCommitmentTextLbl.text = Constants.studentCommitment
        overAllTextLbl.text = Constants.overAllAssessment
        noteTextLbl.text = Constants.note + ":"
    }


    private func setupIntailData(report: LessonReport){
        knowledgeOfSubjectLabel.text = String(report.scientificScore ?? 0)
        comprehensionAbilityLabel.text = String(report.absorbScore ?? 0)
        studentCommitmentLabel.text = String(report.commitmentScore ?? 0)
        ovelallLabel.text = String(report.globalScore ?? 0)
        noteLabel.text = report.note ?? "-"
        
    }
}
