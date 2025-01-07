//
//  ValidationService.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 08/12/2024.
//

import Foundation

extension String {
    var validationLocalized: String {
        return NSLocalizedString(self, tableName: "ValidationLocalized", bundle: Bundle.main, value: "", comment: "")
    }
    func trimWhiteSpace() -> String {
            return self.trimmingCharacters(in: .whitespaces)
        }
    func isValid(pattern: String) -> Bool {
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: self.count)
            return regex?.firstMatch(in: self, options: [], range: range) != nil
        }
}

struct ValidationService {
    
    //MARK: - Name -

    static func validate(name: String?) throws -> String {
        guard let name = name, !name.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyName
        }
        guard name.count > 2 else {
            throw ValidationError.shortName
        }
        guard name.count < 61 else {
            throw ValidationError.longName
        }
        return name
    }
    
    //MARK: - Phone -
    static func validate(phone: String?) throws -> String {
        guard let phone = phone, !phone.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPhoneNumber
        }
        guard phone.isValid(pattern: RegularExpression.saudiArabiaPhone) else {
            throw ValidationError.incorrectPhoneNumber
        }
//        guard phone.count > 8 else {
//            throw ValidationError.incorrectPhoneNumber
//        }
        return phone
    }
    
    static func validate(countryCode: String?) throws -> String {
        guard let countryCode = countryCode, countryCode != "" else{
            throw ValidationError.emptyCountryCode
        }
        return countryCode
    }
    
    //MARK: - Verification code -
    static func validate(verificationCode: String?) throws -> String {
        guard let verificationCode = verificationCode, !verificationCode.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyVerificationCode
        }
        guard verificationCode.count == 4 else {
            throw ValidationError.incorrectVerificationCode
        }
        return verificationCode
    }
    
    //MARK: - Email -
//    static func validate(email: String?) throws -> String {
//        guard let email = email, !email.trimWhiteSpace().isEmpty else {
//            throw ValidationError.emptyMail
//        }
//        guard email.isValidEmail() else{
//            throw ValidationError.wrongMail
//        }
//        return email
//    }
    
    //MARK: - Passwords -
    static func validate(password: String?) throws -> String {
        guard let password = password, !password.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPassword
        }
        guard password.count > 7 else {
            throw ValidationError.shortPassword
        }
        guard password.isValid(pattern: RegularExpression.password) else {
            throw ValidationError.notMatchPasswords
        }
        return password
    }
    static func validate(newPassword: String?) throws -> String {
        guard let newPassword = newPassword, !newPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyNewPassword
        }
        guard newPassword.count > 5 else {
            throw ValidationError.shortNewPassword
        }
        return newPassword
    }
    static func validate(oldPassword: String?) throws -> String {
        guard let oldPassword = oldPassword, !oldPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyOldPassword
        }
        guard oldPassword.count > 5 else {
            throw ValidationError.shortOldPassword
        }
        return oldPassword
    }
    static func validate(newPassword: String, confirmNewPassword: String?) throws -> String {
        guard let confirmNewPassword = confirmNewPassword, !confirmNewPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyConfirmNewPassword
        }
        guard newPassword == confirmNewPassword else {
            throw ValidationError.notMatchPasswords
        }
        return newPassword
    }
    static func validate(newPassword: String, confirmPassword: String?) throws -> String {
        guard let confirmPassword = confirmPassword, !confirmPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyConfirmPassword
        }
        guard newPassword == confirmPassword else {
            throw ValidationError.confirmPasswordNotMatchPassword
        }
        return newPassword
    }
    static func validate(termesAgreed: Bool) throws -> Bool{
        guard termesAgreed else {
            throw ValidationError.terms
        }
        return true
    }
    
    //MARK: - Location -
    static func validate(countryId: Int?) throws -> Int {
        guard let countryId = countryId else {
            throw ValidationError.emptyCountry
        }
        return countryId
    }
    static func validate(governorateId: Int?) throws -> Int {
        guard let governorateId = governorateId else {
            throw ValidationError.emptyGovernorate
        }
        return governorateId
    }
    static func validate(cityId: Int?) throws -> Int {
        guard let cityId = cityId else {
            throw ValidationError.emptyCity
        }
        return cityId
    }
    
    static func validate(regionId: Int?) throws -> Int {
        guard let regionId = regionId else {
            throw ValidationError.emptyRegion
        }
        return regionId
    }
    
    static func validate(areaId: Int?) throws -> Int {
        guard let areaId = areaId else {
            throw ValidationError.emptyArea
        }
        return areaId
    }
    static func validate(streetName: String?) throws -> String {
        guard let streetName = streetName, !streetName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyStreet
        }
        return streetName
    }
    static func validate(department: String?) throws -> String {
        guard let department = department, !department.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyStreet
        }
        return department

    }
    static func validate(addressType: String?) throws -> String {
        guard let addressType = addressType, !addressType.trimWhiteSpace().isEmpty else {
            throw ValidationError.addressType
        }
        return addressType
    }
    static func validate(addressDetails: String?) throws -> String {
        guard let addressDetails = addressDetails, !addressDetails.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyAddressDetails
        }
        return addressDetails
    }
    static func validateLocation(address: String?, lat: Double?, long: Double?) throws -> (address: String, lat: Double, long: Double) {
        guard let address = address, let lat = lat, let long = long else {
            throw ValidationError.emptyLocation
        }
        return (address, lat, long)
    }
    
    //MARK: - Images -
    static func validate(profilePicture: Data?) throws -> Data {
        guard let profilePicture = profilePicture else {
            throw ValidationError.profilePicture
        }
        return profilePicture
    }
    static func validate(licensePicture: Data?) throws -> Data {
        guard let licensePicture = licensePicture else {
            throw ValidationError.licensePicture
        }
        return licensePicture
    }
    static func validate(productPicture: Data?) throws -> Data {
        guard let productPicture = productPicture else {
            throw ValidationError.productPicture
        }
        return productPicture
    }
    
    //MARK: - Cars -
    static func validate(carPicture: Data?) throws -> Data {
        guard let carPicture = carPicture else {
            throw ValidationError.carPicture
        }
        return carPicture
    }
    static func validate(carPlate: String?) throws -> String {
        guard let carPlate = carPlate, !carPlate.trimWhiteSpace().isEmpty else {
            throw ValidationError.carPlate
        }
        return carPlate
    }
    static func validate(carModel: Int?) throws -> Int {
        guard let carModel = carModel else {
            throw ValidationError.carModel
        }
        return carModel
    }
    static func validate(carType: Int?) throws -> Int {
        guard let carType = carType else {
            throw ValidationError.carType
        }
        return carType
    }
    
    //MARK: - Date -
//    static func validate(age: String?) throws -> String {
//        guard let age = age, !age.trimWhiteSpace().isEmpty else {
//            throw ValidationError.emptyAge
//        }
//        guard age.toInt() > 0 else {
//            throw ValidationError.youngAge
//        }
//        return age
//    }
//    static func validate(oldDate: String?) throws -> String {
//        guard let oldDate = oldDate, let date = oldDate.toDate() else {
//            throw ValidationError.emptyDate
//        }
//        guard date.isBeforeNow() else {
//            throw ValidationError.notOldDate
//        }
//        return oldDate
//    }
//    static func validate(newDate: String?) throws -> String {
//        guard let newDate = newDate, let date = newDate.toDate() else {
//            throw ValidationError.emptyDate
//        }
//        guard date.isBeforeNow() else {
//            throw ValidationError.notNewDate
//        }
//        return newDate
//    }
//    static func validate(date: String?) throws -> String {
//        guard let date = date, !date.trimWhiteSpace().isEmpty else {
//            throw ValidationError.emptyDate
//        }
//        return date
//    }
    
    //MARK: - Message -
    static func validate(title: String?) throws -> String {
        guard let title = title, !title.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyTitle
        }
        return title
    }
    static func validate(message: String?) throws -> String {
        guard let message = message, !message.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyMessage
        }
        return message
    }
    static func validate(titleType: String?) throws -> String {
        guard let titleType = titleType, !titleType.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyTitleType
        }
        return titleType
    }
    
    //MARK: - Bank -
    static func validate(bankAccountHolder: String?) throws -> String {
        guard let bankAccountHolder = bankAccountHolder, !bankAccountHolder.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankAccountHolder
        }
        return bankAccountHolder
    }
    static func validate(bankName: String?) throws -> String {
        guard let bankName = bankName, !bankName.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankName
        }
        return bankName
    }
    static func validate(fromBankName: String?) throws -> String {
        guard let fromBankName = fromBankName, !fromBankName.trimWhiteSpace().isEmpty else {
            throw ValidationError.fromBankName
        }
        return fromBankName
    }
    static func validate(bankAccountNumber: String?) throws -> String {
        guard let bankAccountNumber = bankAccountNumber, !bankAccountNumber.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankAccountNumber
        }
        return bankAccountNumber
    }
    static func validate(bankTransferImage: Data?) throws -> Data {
        guard let bankTransferImage = bankTransferImage else {
            throw ValidationError.bankTransferImage
        }
        return bankTransferImage
    }
    
    //MARK: - Categories -
    static func validate(categoryId: Int?) throws -> Int {
        guard let categoryId = categoryId else {
            throw ValidationError.emptyCategory
        }
        return categoryId
    }
//    static func validate(priceBefore: String?, priceAfter: String?) throws -> (priceBefore: String, priceAfter: String) {
//        guard let priceBefore = priceBefore, !priceBefore.trimWhiteSpace().isEmpty else {
//            throw ValidationError.emptyPriceBefore
//        }
//        guard let priceAfter = priceAfter, !priceAfter.trimWhiteSpace().isEmpty else {
//            throw ValidationError.emptyPriceAfter
//        }
//        guard priceBefore.toDouble() > priceAfter.toDouble() else {
//            throw ValidationError.priceBeforeSmallThanPriceAfter
//        }
//        return (priceBefore, priceAfter)
//        
//    }
    static func validate(description: String?) throws -> String {
        guard let description = description, !description.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyDescription
        }
        return description
    }
    
    // MARK: - Complaint
    static func validate(complaint: String?) throws -> String {
        guard let complaint = complaint, !complaint.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyComplaint
        }
        
        guard complaint.count > 2 else {
            throw ValidationError.shortComplaint
        }
        return complaint
    }
    
    static func validate(complaintReason: String?) throws -> String {
        guard let complaintReason = complaintReason, !complaintReason.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyComplaintReason
        }
        
        guard complaintReason.count > 2 else {
            throw ValidationError.shortComplaintReason
        }
        return complaintReason
    }
    
    static func validate(complaintDetails: String?) throws -> String {
        guard let complaintDetails = complaintDetails, !complaintDetails.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyComplaintDetails
        }
        
        guard complaintDetails.count > 2 else {
            throw ValidationError.shortComplaintDetails
        }
        return complaintDetails
    }
    
    static func validate(complaintImage: Data?) throws -> Data {
        guard let complaintImage = complaintImage else {
            throw ValidationError.emptyComplaintDetails
        }
        return complaintImage
    }
    
    
    
    // MARK: - Wallet
    static func validate(chargingValue: String?) throws -> String{
        guard let chargingValue = chargingValue, !chargingValue.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyChargingValue
        }
        return chargingValue
    }
    
    // MARK: - Cart
    static func validate(recivingDate: String?) throws -> String{
        guard let recivingDate = recivingDate, !recivingDate.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyRecivingDate
        }
        return recivingDate
    }
    
    // MARK: - Order
    static func validate(cancelReason: String?) throws -> String{
        guard let cancelReason = cancelReason, !cancelReason.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyCancelReason
        }
        return cancelReason
    }
    
    static func validate(returnReason: String?) throws -> String{
        guard let returnReason = returnReason, !returnReason.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyReturnReason
        }
        return returnReason
    }
    
    static func validate(invoiceImage: Data?) throws -> Data {
        guard let invoiceImage = invoiceImage else {
            throw ValidationError.emptyinvoiceImage
        }
        return invoiceImage
    }
    
}


