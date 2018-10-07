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
    
    var eligibilityVC : EligibilityCheckVC?
    
    init(_ navigator : Navigator) {
        eligibilityVC = EligibilityCheckVC.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
//        navigator.setAsRoot(eligibilityCV!)
        eligibilityVC?.onDidLoad(callback: { (eligibilityView) in
            self.regCellNib()

        })
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.appYellow

        return cell
    }
    
    
    
}
