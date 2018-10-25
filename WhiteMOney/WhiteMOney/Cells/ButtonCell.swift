//
//  ButtonCell.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var middleNextBtn: UIButton!
    @IBOutlet weak var middleNextBtnImg: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextBtnImg: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backBtnImg: UIImageView!
    
    @IBOutlet weak var backAndCancelView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        renderImg()
        middleNextBtn.setTitleColor(UIColor.secondaryBrandingColor(), for: .normal) 
        middleNextBtn.backgroundColor = UIColor.primaryBrandingColor()
        middleNextBtn.applyDropShaddow(UIColor.lightGray)
    }
    func setAsMiddleBtnActive(_ activeMiddle : Bool) -> Void {
        if !activeMiddle {
            middleNextBtnImg.isHidden = true
            middleNextBtn.isHidden = true
            backAndCancelView.isHidden = false
        }else{
            middleNextBtnImg.isHidden = false
            middleNextBtn.isHidden = false
            backAndCancelView.isHidden = true
        }
    }
    func renderImg() -> Void {
        if middleNextBtnImg != nil {
            middleNextBtnImg.renderImgWithColor(UIColor.primaryBrandingColor())
        }
        if nextBtnImg != nil {
            nextBtnImg.renderImgWithColor(UIColor.primaryBrandingColor())
        }
        if backBtnImg != nil {
           backBtnImg.renderImgWithColor(UIColor.primaryBrandingColor())
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
