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
    var fieldsArray : [AuthDataModel.TypeOfCellField]?
    var authDataModel : AuthDataModel?
    var eligibilityVC : EligibilityCheckVC?
    var eligibilityCheckModel = AuthDataModel.EligibilityCheckModel()
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
        fieldsArray = [.addAddressField ,.showAddressField,.panCardField,.aadharCardField,.employmentType,.anualIncome,.currentCompanyName,.monthlyIncome]
        if eligibilityCheckModel.address == nil{
            
        } else {
            
        }
        eligibilityVC?.fieldsTblView.reloadData()
    }
}


extension EligibilityCheckViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "FloatingTxtFieldCell", bundle: Bundle.main)
        eligibilityVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "FloatingTxtFieldCell")
        eligibilityVC?.fieldsTblView.dataSource = self
        eligibilityVC?.fieldsTblView.delegate = self
        eligibilityVC?.fieldsTblView.reloadData()
        eligibilityVC?.fieldsTblView.setDynamicCellHeight()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell?
        let field = fieldsArray?[indexPath.row]
        switch field {
        case .addAddressField?:
            cell = tableView.dequeueReusableCell(withIdentifier: "addAddressCell")
        case .showAddressField?:
            cell = tableView.dequeueReusableCell(withIdentifier: "ShowAddress")
            
        case .panCardField?:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell

        case .aadharCardField?:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell

        case .employmentType?:
            cell = tableView.dequeueReusableCell(withIdentifier: "EmploymentTypeCell")
            if let segmentControl = cell?.contentView.viewWithTag(100) as? UISegmentedControl{
                let font = UIFont.systemFont(ofSize: 16)
                segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: font],
                                                      for: UIControlState.normal)

            }
        case .anualIncome?:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            
        case .currentCompanyName?:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
        case .monthlyIncome?:
            cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell

            
            
        default:
            cell = UITableViewCell()
        }
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    
    
}
// addAddressCell
//ShowAddress

func setupSections() -> Void {
    
}

//1) address => addr 1,addr 2 ,city,state,country,pin,
//2) employment Type
//3) company name and salary / anual incom
//4) pan and Aadhar
