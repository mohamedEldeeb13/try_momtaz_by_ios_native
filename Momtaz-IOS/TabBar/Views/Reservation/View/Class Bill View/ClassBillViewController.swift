//
//  ClassBillViewController.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 21/01/2025.
//

import UIKit

class ClassBillViewController: UIViewController {
    
    //MARK: outlets
    
    @IBOutlet weak var headTextLbl: UILabel!
    @IBOutlet weak var packageTypeTextLbl: UILabel!
    @IBOutlet weak var packageType: UILabel!
    @IBOutlet weak var classPriceTextLbl: UILabel!
    @IBOutlet weak var classPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var totalPriceTextLbl: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    //MARK: data will passed
    var pckType: String!
    var numberOfSessions: Int!
    var price: String!
    var teacherPrice: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpIntailData()
    }
    
    private func setUpIntailData(){
        headTextLbl.text = Constants.billInformations
        packageTypeTextLbl.text = pckType == "MONTHLY" ? Constants.monthly : Constants.oneClass
        packageType.text = pckType == "MONTHLY" ? "\(numberOfSessions!) \(Constants.classPerWeek)" :"1 \(Constants.oneClasses)"
        classPriceTextLbl.text = Constants.classPrice
        classPrice.text = price
        totalPriceTextLbl.text = Constants.total
        totalPrice.text = teacherPrice
        discountPrice.text = subtractNumbers(num1: price, num2: teacherPrice)
        
        
    }
    
    private func subtractNumbers(num1: String, num2: String) -> String {
        // Convert the string inputs to Decimal for precise calculations
        guard let number1 = Decimal(string: num1), let number2 = Decimal(string: num2) else {
            return "Invalid input"
        }
        
        // Perform the subtraction
        let result = number1 - number2
        
        // Return the result as a string
        let StringResult = NSDecimalNumber(decimal: result).stringValue
        return "- \(StringResult)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
