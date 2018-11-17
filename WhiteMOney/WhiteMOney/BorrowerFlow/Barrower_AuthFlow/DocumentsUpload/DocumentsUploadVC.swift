//
//  DocumentsUploadVC.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class DocumentsUploadVC: UIViewController {
    var didLoad : (UIViewController)->Void = {_ in}
    var willAppear : (UIViewController)->Void = {_ in}

    @IBOutlet weak var fieldsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad(self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        willAppear(self)
    }
    
    
    func onDidLoad(callback: @escaping (UIViewController)->Void) {
        didLoad = callback
    }
    func onWillAppear(callback: @escaping (UIViewController)->Void) {
        willAppear = callback
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}