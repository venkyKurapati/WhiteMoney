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
import Async
import Photos

class DocumentsPicker: NSObject,UINavigationControllerDelegate
{
    var parentVC : UIViewController?
    var importMenu : UIDocumentMenuViewController?
    let imgPicker = UIImagePickerController.init()
    var didPickDoc :(_ data : Data?,_ name : String?)->Void = {_,_ in }
    init(_ source : UIViewController) {
        super.init()
        parentVC = source
        importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeImage)], in: .import)
        importMenu?.delegate = self
        importMenu?.modalPresentationStyle = .formSheet
        self.imgPicker.delegate = self
        self.imgPicker.mediaTypes = [kUTTypeImage as String]
//        importMenu?.addOption(withTitle: "Photos", image: nil, order: UIDocumentMenuOrder.first, handler: {
//            self.checkPermission({accessable in
//                if (accessable != true) {return}
//                 Async.main({
//                    self.parentVC?.present(self.imgPicker, animated: true, completion: {
//                    })
//                })
//            })
//
//        })

    }
    
    func show(_ didPickItem :@escaping (_ data : Data?,_ name : String?)->Void) -> Void {
        Async.main({
            self.didPickDoc = didPickItem
            self.parentVC?.present(self.imgPicker, animated: true, completion: {
            })

//            if let menu = self.importMenu {
//                self.parentVC?.present(menu, animated: true, completion: nil)
//            }
        })
      
    }
    
}
    
extension DocumentsPicker:UIDocumentMenuDelegate,UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
        didPickDoc(nil, nil)
        
        do{
            let weatherData = try NSData(contentsOf: myURL, options: NSData.ReadingOptions())
            let activityItems = [weatherData]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            if UI_USER_INTERFACE_IDIOM() == .phone {
                Async.main({
                    self.parentVC?.present(activityController, animated: true, completion: nil)
                })
            }

        }catch{
            
        }
        
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

extension DocumentsPicker: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        NSLog("\(info)")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if let data = UIImagePNGRepresentation(image)  {
                didPickDoc(data as Data, "")
            }
            
        }

//        imagePickerController(picker, pickedImage: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
        
    }
    func checkPermission(_ callback:@escaping (Bool)-> Void) {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
            
        case .authorized: print("Access is granted by user")
            callback(true)

        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization({ (newStatus) in print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized { print("success")
                    callback(newStatus == .authorized)
                }
                
            })
                
        case .restricted:  print("User do not have access to photo album.")

        case .denied:  print("User has denied the permission.")
            
            
        }
                
        
    }
       
}
