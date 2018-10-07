//
//  SideMenuOption.swift
//  WhiteMoney
//
//  Created by Exequiel Banga on 21/11/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class SideMenuOption: NSObject {
    var image: UIImage!
    var name: String!
    var onSelect: (()->())?
    
    init(_ name: String , _ image : UIImage, onSelect: @escaping (()->()) ) {
        self.image = image
        self.name = name
        self.onSelect = onSelect
    }
    
}
