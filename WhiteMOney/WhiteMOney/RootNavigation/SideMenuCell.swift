//  
//  SideMenuCell.swift
//  WhiteMoney2
//
//  Created by Leandro Linardos on 03/04/2018.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import UIKit

class SideMenuCell : UITableViewCell {
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    
}
