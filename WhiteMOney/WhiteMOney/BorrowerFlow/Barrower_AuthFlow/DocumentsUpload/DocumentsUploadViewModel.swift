//
//  DocumentsUploadViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit
import Async

class DocumentsUploadViewModel: NSObject {
    var fieldsArray : [Barrower_AuthDataModel.TypeOfCellField]?
    var authDataModel : Barrower_AuthDataModel?
    var documentsInfo : Barrower_AuthDataModel.DocumentsUploadModel?
    var documentsUploadVC : DocumentsUploadVC?
    var documentPicker : DocumentsPicker?
    var didFinishStep : ()->Void = {}
    var didCancelStep : ()->Void = {}
    init(_ navigator : Navigator) {
        documentsUploadVC = DocumentsUploadVC.instanciateFrom(storyboard: Storyboards.Barrower_AuthFlow)
        
        super.init()
        documentsInfo = Barrower_AuthDataModel.DocumentsUploadModel()
        documentsUploadVC?.onDidLoad(callback: { (eligibilityView) in
            self.regCellNib()
            self.setupCellIdentifiers()
            
        })
        documentsUploadVC?.onWillAppear(callback: {_ in
            
            
        })
    }
    func setupCellIdentifiers() -> Void {
        fieldsArray = [.uploadPhoto,.uploadPanCard,.uploadProofOfResidence,.uploadSalarySlip,.uploadITR,.bankStatements,.nextWithCancel]
        documentsUploadVC?.fieldsTblView.reloadData()
    }
    func didFinishUploadDocStep(_ finishUploadDocStep : @escaping ()->Void) -> Void {
        didFinishStep = finishUploadDocStep
    }
    func didCancelEligibilityStep(_ cancelEligibilityStep : @escaping ()->Void) -> Void {
        didCancelStep = cancelEligibilityStep
    }
}


extension DocumentsUploadViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "UploadDocumentCell", bundle: Bundle.main)
        documentsUploadVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "UploadDocumentCell")
        let nibbtn = UINib.init(nibName: "ButtonCell", bundle: Bundle.main)
        documentsUploadVC?.fieldsTblView.register(nibbtn, forCellReuseIdentifier: "ButtonCell")

        documentsUploadVC?.fieldsTblView.dataSource = self
        documentsUploadVC?.fieldsTblView.delegate = self
        documentsUploadVC?.fieldsTblView.reloadData()
        documentsUploadVC?.fieldsTblView.setDynamicCellHeight()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let field = fieldsArray?[indexPath.row]



        var cell = UITableViewCell()
        switch field! {
            case .nextWithCancel:
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            cellBtn.setAsMiddleBtnActive(false)
            cellBtn.nextBtn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
            cellBtn.backBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
            cell = cellBtn
            
        default:
            let uploadDocumentCell = tableView.dequeueReusableCell(withIdentifier: "UploadDocumentCell") as! UploadDocumentCell
            uploadDocumentCell.fieldType = field
            uploadDocumentCell.documentsModel = documentsInfo
            uploadDocumentCell.documentTypeLbl.text = (field).map { $0.rawValue }
            uploadDocumentCell.browsBtn.tag = indexPath.row
            uploadDocumentCell.browsBtn.addTarget(self, action: #selector(didTappedOnBrows(_:)), for: .touchUpInside)
            uploadDocumentCell.selectionStyle = .none
            uploadDocumentCell.updateCellContent()
            cell = uploadDocumentCell
        }
        return cell
    }
    
    @objc func nextBtnAction() -> Void {
        didFinishStep()
    }
    @objc func cancelBtnAction() -> Void {
        didCancelStep()
    }
    @objc func didTappedOnBrows(_ sender : UIButton) -> Void {
        documentPicker = DocumentsPicker.init(documentsUploadVC!)
        documentPicker?.show({data,fileName in
            self.setModelWithData(sender.tag, data: data, fileName: fileName)
            
        })
    }
    
    func setModelWithData(_ fieldIndex: Int , data : Data? , fileName  : String?) -> Void {
        let fieldType = fieldsArray?[fieldIndex]
        switch fieldType! {
        case .uploadPhoto:
            documentsInfo?.uploadedPhotoData = data
        case .uploadPanCard:
            documentsInfo?.uploadedPanCard = data

        case .uploadProofOfResidence:
            documentsInfo?.uploadedProofOfResidence = data

        case .uploadSalarySlip:
            documentsInfo?.uploadedSalarySlip = data
        case .uploadITR:
            documentsInfo?.uploadedITR = data

        case .bankStatements:
            documentsInfo?.bankStatements = data

        default:
            break
        }
        Async.main({
            self.documentsUploadVC?.fieldsTblView.beginUpdates()
            self.documentsUploadVC?.fieldsTblView.reloadRows(at: [IndexPath.init(row: fieldIndex, section: 0)], with: .none)
            self.documentsUploadVC?.fieldsTblView.endUpdates()
        })
    }
    
    func didTappedOnUpload(_ sender : UIButton) -> Void {
        
    }
    
    
}
