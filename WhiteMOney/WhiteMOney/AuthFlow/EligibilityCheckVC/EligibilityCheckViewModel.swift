//
//  EligibilityCheckViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit


class EligibilityCheckViewModel: NSObject {
//    var fieldsArray : [AuthDataModel.TypeOfCellField]?
    var authDataModel : AuthDataModel?
    var eligibilityVC : EligibilityCheckVC?
    var eligibilityCheckModel = AuthDataModel.EligibilityCheckModel()
    var didFinishStep : ()->Void = {}
    var didCancelStep : ()->Void = {}
    var employmentFields = [AuthDataModel.TypeOfCellField]()
    var commonFields = [AuthDataModel.TypeOfCellField]()
    
    init(_ navigator : Navigator) {
        eligibilityVC = EligibilityCheckVC.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
//        navigator.setAsRoot(eligibilityCV!)
        eligibilityVC?.onDidLoad(callback: { (eligibilityView) in
            self.regCellNib()
            self.setupIdentifiers()
        })
    }
    
    
    func setupIdentifiers() -> Void {
        employmentFields = [.employmentType]
        if eligibilityCheckModel.employementType == .selfEmployed {
           employmentFields.append(.anualIncome)
        }else{
            employmentFields.append(.currentCompanyName)
            employmentFields.append(.monthlyIncome)
        }
        commonFields = [.panCardField ,.aadharCardField,.addressLine1,.addressLine2,.cityField, .stateField,.pinCode,.nextWithCancel]

        eligibilityVC?.fieldsTblView.reloadData()
    }
    func didFinishEligibilityStep(_ finishEligibilityStep : @escaping ()->Void) -> Void {
        didFinishStep = finishEligibilityStep
    }
    func didCancelEligibilityStep(_ cancelEligibilityStep : @escaping ()->Void) -> Void {
        didCancelStep = cancelEligibilityStep
    }

}


extension EligibilityCheckViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "FloatingTxtFieldCell", bundle: Bundle.main)
        eligibilityVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "FloatingTxtFieldCell")
        let nibBtn = UINib.init(nibName: "ButtonCell", bundle: Bundle.main)
        eligibilityVC?.fieldsTblView.register(nibBtn, forCellReuseIdentifier: "ButtonCell")
        
        eligibilityVC?.fieldsTblView.dataSource = self
        eligibilityVC?.fieldsTblView.delegate = self
        eligibilityVC?.fieldsTblView.reloadData()
        eligibilityVC?.fieldsTblView.setDynamicCellHeight()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return employmentFields.count
        }else{
            return commonFields.count
        }
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return nil
//        }else{
//            return "Personal Details"
//        }
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//        let header = (view as! UITableViewHeaderFooterView)
//        header.backgroundView?.backgroundColor = UIColor.clear
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var field : AuthDataModel.TypeOfCellField{
            get{
                if indexPath.section == 0 {
                    return employmentFields[indexPath.row]
                }else{
                    return commonFields[indexPath.row]
                }
            }
        }
        
        
        switch field {
            
        case .employmentType:
            cell = tableView.dequeueReusableCell(withIdentifier: "EmploymentTypeCell")!
            if let segmentControl = cell.contentView.viewWithTag(100) as? UISegmentedControl{
                let font = UIFont.systemFont(ofSize: 16)
                segmentControl.tintColor = UIColor.primaryBrandingColor()
                segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: font],
                                                      for: UIControlState.normal)
                segmentControl.addTarget(self, action: #selector(didTappedOnEmploymentType(_:)), for: .valueChanged)
                segmentControl.selectedSegmentIndex = (eligibilityCheckModel.employementType == .selfEmployed) ? 1 : 0
                
            }
            
            
        case .nextWithCancel:
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cellBtn.setAsMiddleBtnActive(false)
            cellBtn.nextBtn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
            cellBtn.backBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
            cell = cellBtn

            
        case .panCardField:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.panCardNumber, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

        case .aadharCardField:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.aadharCardNumber, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell


        case .addressLine1:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.address.addressLine1, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell


        case .addressLine2:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.address.addressLine2, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

            
        case .cityField:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.address.city, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

        case .stateField:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.address.state, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

        case .pinCode:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.address.pinCode, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)

            cell = floatingTxtCell


        case .anualIncome:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.netAnnualIncome, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

            
        case .currentCompanyName:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.nameOfCurrentCompany, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

        case .monthlyIncome:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            floatingTxtCell.setUpUserFieldDetailsOfUser(eligibilityCheckModel.monthlyInHandSalary, typeOfTxtField: field, inputAccessoryView: nil, delegate: self)
            cell = floatingTxtCell

            
        default:
            break
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    @objc func didTappedOnEmploymentType(_ sender : UISegmentedControl){
        if sender.selectedSegmentIndex == 1{
            eligibilityCheckModel.employementType = .selfEmployed
        }else{
            eligibilityCheckModel.employementType = .salaried
        }
        setupIdentifiers()
    }
    
    @objc func nextBtnAction() -> Void {
        if validateFields(){
            didFinishStep()
        }
    }
    @objc func cancelBtnAction() -> Void {
        didCancelStep()
    }
    
}

// addAddressCell
//ShowAddress

//func setupSections() -> Void {
//
//}

//1) address => addr 1,addr 2 ,city,state,country,pin,
//2) employment Type
//3) company name and salary / anual incom
//4) pan and Aadhar
extension EligibilityCheckViewModel: FloatingTxtFieldDelegate{
    func floatingTxtFieldShouldBeginEditing(_ textField: FloatingTxtField) -> Bool {
        return true
    }
    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField) {
        
        
    }
    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField, reason: UITextFieldDidEndEditingReason)
    {
        self.floatingTxtFieldDidEndEditing(textField)
    }
    func floatingTxtField(_ textField: FloatingTxtField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            switch textField.placeHoleder {
            case Constants.annualIncomePlaceholder:
                eligibilityCheckModel.netAnnualIncome = updatedText
            case Constants.monthlySalaryInHandPlaceholder:
                eligibilityCheckModel.monthlyInHandSalary = updatedText
            case Constants.currentCompanyNamePlaceholder:
                eligibilityCheckModel.nameOfCurrentCompany = updatedText
            case Constants.panCardNumPlaceholder:
                eligibilityCheckModel.panCardNumber = updatedText
            case Constants.aadharCardNumPlaceholder:
                eligibilityCheckModel.aadharCardNumber = updatedText
            case Constants.add1Placeholder:
                eligibilityCheckModel.address.addressLine1 = updatedText
            case Constants.add2Placeholder:
                eligibilityCheckModel.address.addressLine2 = updatedText
            case Constants.cityPlaceholder:
                eligibilityCheckModel.address.city = updatedText
            case Constants.statePlaceholder:
                eligibilityCheckModel.address.state = updatedText
            case Constants.pinCodePlaceholder:
                eligibilityCheckModel.address.pinCode = updatedText
            default:
                break
            }
        }
        return true
    }
    func validateFields() -> Bool {
        switch eligibilityCheckModel.employementType {
        case .selfEmployed:
            if eligibilityCheckModel.netAnnualIncome.isEmpty{
                eligibilityVC?.showCustomToast(message: ErrorMessages.annualIncomeEmptyErrorMsg)
                return false
            }
        default:
            if eligibilityCheckModel.nameOfCurrentCompany.isEmpty{
                eligibilityVC?.showCustomToast(message: ErrorMessages.currentCompanyNameEmptyErrorMsg)
                return false
            }else if eligibilityCheckModel.monthlyInHandSalary.isEmpty{
                eligibilityVC?.showCustomToast(message: ErrorMessages.monthlySalaryInHandEmptyErrorMsg)
                return false
            }
        }
        if !eligibilityCheckModel.panCardNumber.isEmpty {
            if !eligibilityCheckModel.aadharCardNumber.isEmpty {
                if !eligibilityCheckModel.address.addressLine1.isEmpty {
                    if !eligibilityCheckModel.address.addressLine2.isEmpty {
                        if !eligibilityCheckModel.address.city.isEmpty {
                            if !eligibilityCheckModel.address.state.isEmpty {
                                if !eligibilityCheckModel.address.pinCode.isEmpty {
                                    return true
                                }else{
                                    eligibilityVC?.showCustomToast(message: ErrorMessages.pinCodeEmptyErrorMsg)
                                    return false
                                }
                            }else{
                                eligibilityVC?.showCustomToast(message: ErrorMessages.stateEmptyErrorMsg)
                                return false
                            }
                        }else{
                            eligibilityVC?.showCustomToast(message: ErrorMessages.cityEmptyErrorMsg)
                            return false
                        }
                    }else{
                        eligibilityVC?.showCustomToast(message: ErrorMessages.addressLine2EmptyErrorMsg)
                        return false
                    }
                }else{
                    eligibilityVC?.showCustomToast(message: ErrorMessages.addressLine1EmptyErrorMsg)
                    return false
                }
            }else{
                eligibilityVC?.showCustomToast(message: ErrorMessages.aadharCardNumberEmptyErrorMsg)
                return false
            }
        }else{
            eligibilityVC?.showCustomToast(message: ErrorMessages.panCardNumberEmptyErrorMsg)
            return false
        }
    }
    
}
