//
//  UploadDocumentCell.swift
//  WhiteMOney
//
//  Created by Venkatesh on 25/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async

class UploadDocumentCell: UITableViewCell {

    @IBOutlet weak var documentTypeLbl: UILabel!
    @IBOutlet weak var browsBtn: UIButton!
    var fieldType : AuthDataModel.TypeOfCellField?
    var documentsModel : AuthDataModel.DocumentsUploadModel?
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var uploadViewHeight: NSLayoutConstraint!
    @IBOutlet weak var uploadedFileImgView: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var fileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }
    func updateUI(){
       documentTypeLbl.font = UIFont.appTextFont()
        fileName.text = ""
        uploadBtn.backgroundColor = UIColor.primaryBrandingColor()
        uploadBtn.setTitleColor(UIColor.secondaryBrandingColor(), for: .normal)
        uploadBtn.titleLabel?.font = UIFont.appSemiboldFont(ofSize: 17)
        uploadBtn.applyDropShaddow(UIColor.lightGray)
        uploadedFileImgView.applyDropShaddow(UIColor.lightGray)
        browsBtn.backgroundColor = UIColor.secondaryBrandingColor()
        browsBtn.setTitleColor(UIColor.primaryBrandingColor(), for: .normal)
        browsBtn.titleLabel?.font = UIFont.appSemiboldFont(ofSize: 17)
        browsBtn.applyDropShaddow(UIColor.lightGray)

    }
    
  
    
    func updateCellContent() -> Void {
        var isBrowsedAlready = false
        var data : Data?
        switch fieldType! {
        case .uploadPhoto:
            isBrowsedAlready  = documentsModel?.uploadedPhotoData != nil
            data = documentsModel?.uploadedPhotoData
        case .uploadPanCard:
            isBrowsedAlready  = documentsModel?.uploadedPanCard != nil
            data = documentsModel?.uploadedPanCard

        case .uploadProofOfResidence:
            isBrowsedAlready  = documentsModel?.uploadedProofOfResidence != nil
            data = documentsModel?.uploadedProofOfResidence

        case .uploadSalarySlip:
            isBrowsedAlready  = documentsModel?.uploadedSalarySlip != nil
            data = documentsModel?.uploadedSalarySlip

        case .uploadITR:
            isBrowsedAlready  = documentsModel?.uploadedITR != nil
            data = documentsModel?.uploadedITR


        case .bankStatements:
            isBrowsedAlready  = documentsModel?.bankStatements != nil
            data = documentsModel?.bankStatements

        default:
            break
        }
        
//        if let data = data{
        
       // }
        showUploadView(isBrowsedAlready)

        Async.background{ ()->UIImage? in
            let img : UIImage?  = (data != nil) ?  UIImage.init(data: data!) : nil
            return img
        }.main{ img in
            self.uploadedFileImgView.image = img

        }
        
    }
    
    func showUploadView(_ show : Bool) -> Void {
        if show {
            uploadViewHeight.constant = 130.0
            uploadView.isHidden = false
        }else{
            uploadViewHeight.constant = 0.0
            uploadView.isHidden = true
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
