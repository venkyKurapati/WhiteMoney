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
    var fieldsArray : [AuthDataModel.TypeOfCellField]?
    var authDataModel : AuthDataModel?
    var documentsUploadVC : DocumentsUploadVC?
    
    init(_ navigator : Navigator) {
        documentsUploadVC = DocumentsUploadVC.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
//        navigator.setAsRoot(documentsUploadVC!)
        documentsUploadVC?.onDidLoad(callback: { (eligibilityView) in
            self.regCellNib()
            self.setupCellIdentifiers()
            
        })
    }
    func setupCellIdentifiers() -> Void {
        fieldsArray = [.uploadPhoto,.uploadPanCard,.uploadProofOfResidence,.uploadSalarySlip,.uploadITR,.bankStatements]
        documentsUploadVC?.fieldsTblView.reloadData()
    }
}


extension DocumentsUploadViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "UploadDocumentCell", bundle: Bundle.main)
        documentsUploadVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "UploadDocumentCell")
        documentsUploadVC?.fieldsTblView.dataSource = self
        documentsUploadVC?.fieldsTblView.delegate = self
        documentsUploadVC?.fieldsTblView.reloadData()
        documentsUploadVC?.fieldsTblView.setDynamicCellHeight()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UploadDocumentCell") as! UploadDocumentCell
        cell.documentTypeLbl.text = (fieldsArray?[indexPath.row]).map { $0.rawValue }
        cell.browsBtn.tag = indexPath.row
        cell.browsBtn.addTarget(self, action: #selector(didTappedOnBrows(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    @objc func didTappedOnBrows(_ sender : UIButton) -> Void {
        let documentPicker = DocumentsPicker.init(documentsUploadVC!)
        documentPicker.show({
            
            
        })
    }
    func didTappedOnUpload(_ sender : UIButton) -> Void {
        
    }
    
    
}
