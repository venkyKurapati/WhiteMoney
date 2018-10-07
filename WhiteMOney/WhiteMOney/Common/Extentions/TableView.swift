//
//  TableView.swift
//  WhiteMOney
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    func setDynamicCellHeight() -> Void {
        self.estimatedRowHeight = 100
        self.rowHeight = UITableViewAutomaticDimension
        self.separatorStyle = .none
    }
}
