//
//  DocumentsUploadViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit


class DocumentsUploadViewModel: NSObject {
    
    var documentsUploadVC : DocumentsUploadVC?
    
    init(_ navigator : Navigator) {
        documentsUploadVC = DocumentsUploadVC.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
//        navigator.setAsRoot(documentsUploadVC!)
        documentsUploadVC?.onDidLoad(callback: { (eligibilityView) in
            self.regCellNib()
            
        })
    }
}


extension DocumentsUploadViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "FloatingTxtFieldCell", bundle: Bundle.main)
        documentsUploadVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "FloatingTxtFieldCell")
        documentsUploadVC?.fieldsTblView.dataSource = self
        documentsUploadVC?.fieldsTblView.delegate = self
        documentsUploadVC?.fieldsTblView.reloadData()
        documentsUploadVC?.fieldsTblView.setDynamicCellHeight()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.green
        return cell
    }
    
    
    
}
