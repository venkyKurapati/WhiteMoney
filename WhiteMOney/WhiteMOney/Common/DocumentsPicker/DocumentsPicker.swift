//
//  DocumentsPicker.swift
//  WhiteMOney
//
//  Created by Venkatesh on 25/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class DocumentsPicker: NSObject
{
    var parentVC : UIViewController?
    var importMenu : UIDocumentMenuViewController?
    var didPickDoc :()->Void = {}
    init(_ source : UIViewController) {
        super.init()
        parentVC = source
        importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeImage)], in: .import)
        importMenu?.delegate = self
        importMenu?.modalPresentationStyle = .formSheet
        
        importMenu?.addOption(withTitle: "Photos", image: nil, order: UIDocumentMenuOrder.first, handler: {
            let imgPicker = UIImagePickerController.init()
            imgPicker.delegate = self
            self.parentVC?.present(imgPicker, animated: true, completion: {
                
            })
        })

    }
    
    func show(_ didPickItem :@escaping ()->Void) -> Void {
        didPickDoc = didPickItem
        if let menu = importMenu {
            parentVC?.present(menu, animated: true, completion: nil)
        }
    }
    
  

}
extension DocumentsPicker:UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
        didPickDoc()
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        parentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        parentVC?.dismiss(animated: true, completion: nil)
    }
}
