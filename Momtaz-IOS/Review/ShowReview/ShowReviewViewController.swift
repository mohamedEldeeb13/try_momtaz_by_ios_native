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
    var knowldgeSubjectValue: String!
    var studentAbilityValue: String!
    var studentCommitmentValue: String!
    var overAllValue: String!
    var noteValue: String!
    
    //MARK: page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIntailUI()
       setupIntailData()
    }
    
    private func setUpIntailUI(){
        headTextLbl.text = Constants.showReviewHeadText
        knowldgeSubjectTextLbl.text = Constants.knowledgeOfSubject
        studentAbilityTextLbl.text = Constants.studentComprehensionAbility
        studentCommitmentTextLbl.text = Constants.studentCommitment
        overAllTextLbl.text = Constants.overAllAssessment
        noteTextLbl.text = Constants.note + ":"
    }


    private func setupIntailData(){
        knowledgeOfSubjectLabel.text = knowldgeSubjectValue
        comprehensionAbilityLabel.text = studentAbilityValue
        studentCommitmentLabel.text = studentCommitmentValue
        ovelallLabel.text = overAllValue
        noteLabel.text = noteValue
        
    }
}
