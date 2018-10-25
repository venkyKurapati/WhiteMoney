//
//  UploadDocumentCell.swift
//  WhiteMOney
//
//  Created by Venkatesh on 25/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class UploadDocumentCell: UITableViewCell {

    @IBOutlet weak var documentTypeLbl: UILabel!
    
    @IBOutlet weak var browsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }
    func updateUI(){
       documentTypeLbl.font = UIFont.appTextFont()
    }
    func updateCellContent() -> Void {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
