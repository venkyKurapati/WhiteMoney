//
//  OTPField.swift
//  WhiteMOney
//
//  Created by Venkatesh on 09/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class OTPField: XibView {
    @IBOutlet weak var blinkLbl: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var underlineLbl: UILabel!
    var timer : SimpleTimer!

    var underLine_Hilight_ViewColor = UIColor.white
    var underLineViewColor = UIColor.lightGray

    override func commonInit() {
        timer = SimpleTimer.init(interval: 1, onTick: {
            self.blinkLbl.blink(withDuration: 1, color: UIColor.clear)
        })
        super.commonInit()
        blinkLbl.backgroundColor = UIColor.fieldBackgroundColor()
        txtLbl.textColor = UIColor.appPrimaryTextColor()

    }
    func setUpTxtFieldColor( _ underLine_Hilight_ViewColor : UIColor,underLineViewColor : UIColor) -> Void {
        self.underLineViewColor = underLineViewColor
        self.underLine_Hilight_ViewColor = underLine_Hilight_ViewColor
    }
    func startEdit() -> Void {
        self.underlineLbl.backgroundColor = underLine_Hilight_ViewColor
        blinkLbl.isHidden = false
        timer.start()
    }
    func endEdit() -> Void {
        if (txtLbl.text ?? "").count > 0 {
            self.underlineLbl.backgroundColor = underLine_Hilight_ViewColor
        }else{
            self.underlineLbl.backgroundColor = underLineViewColor
        }
        blinkLbl.isHidden = true
        timer.stop()
    }
}


extension UIView{
    public func blink(withDuration duration: Double = 0.25, color: UIColor? = nil) {
        
        alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.alpha = 1.0
        })
        
        guard let newBackgroundColor = color else { return }
        let oldBackgroundColor = backgroundColor
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.backgroundColor = newBackgroundColor
            self.backgroundColor = oldBackgroundColor
        })
        
    }
}
