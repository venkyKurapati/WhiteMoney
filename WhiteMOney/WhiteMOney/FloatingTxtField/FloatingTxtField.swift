//
//  FloatingTxtField.swift
//  Hindware
//
//  Created by Venkatesh on 11/01/18.
//  Copyright © 2018 Vijaya Durga. All rights reserved.
//

import UIKit


@objc protocol FloatingTxtFieldDelegate : class{
    @objc optional  func floatingTxtFieldShouldBeginEditing(_ textField: FloatingTxtField) -> Bool
    @objc optional  func floatingTxtFieldDidBeginEditing(_ textField: FloatingTxtField)
    @objc optional  func floatingTxtFieldShouldEndEditing(_ textField: FloatingTxtField) -> Bool
    @objc optional  func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField)
    @available(iOS 10.0, *)
    @objc optional  func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField, reason: UITextFieldDidEndEditingReason)
    @objc optional  func floatingTxtField(_ textField: FloatingTxtField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional  func floatingTxtFieldShouldClear(_ textField: FloatingTxtField) -> Bool
    @objc optional  func floatingTxtFieldShouldReturn(_ textField: FloatingTxtField) -> Bool
}
extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
@IBDesignable class FloatingTxtField: UIView {

   
    let spacing : CGFloat = 5.0
    var iconImgView = UIImageView()
    var txtField = UITextField()
    var underlineView = UIView()
    var placeHolederLbl = UILabel()
    var warningLbl = UILabel()
    var delegate : FloatingTxtFieldDelegate?
    var placeHolderLblFont : UIFont?
    override func draw(_ rect: CGRect) {
        setUpConstraints()
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addWarningLbl()
//        addUnderLineView()
//        addPlaceHolderLbl()
//
//    }
var constraintsArranged = false
    
    func setUpConstraints() -> Void {

//        self.applyBoarder()
        if !constraintsArranged {
            addWarningLbl()
            addUnderLineView()
            addPlaceHolderLbl()
            constraintsArranged = true
        }

    }
    
    var placeHolderCenterYConstraint : NSLayoutConstraint?
    
    @IBInspectable var txtFieldLeftPaddingWidth : CGFloat = 15.0 {
        didSet{
           setPaddingView()
        }
    }
    func setPaddingView() -> Void {
        let paddingView = UIView(frame: CGRect.init(x:0, y:0, width:txtFieldLeftPaddingWidth, height:30))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
    }
    
    
    //MARK:- Place Holder
    @IBInspectable var placeHolderHeight : CGFloat = 17.0 {
        didSet{
        }
    }
    @IBInspectable var placeHolderFont : UIFont = UIFont.systemFont(ofSize: 10){
        didSet{
            placeHolederLbl.font = placeHolderFont
        }
    }
    @IBInspectable var placeholderTxtColor : UIColor? {
        didSet{
            placeHolederLbl.textColor = placeholderTxtColor
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable var placeHoleder : String? {
        set{
            placeHolederLbl.text = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return placeHolederLbl.text
        }
    }
    
    func addPlaceHolderLbl() -> Void {
        self.addSubview(placeHolederLbl)
        placeHolederLbl.textColor = placeholderTxtColor
        placeHolederLbl.translatesAutoresizingMaskIntoConstraints = false
        _ = placeHolederLbl.setLeadingAnc(txtField.leadingAnchor, withConst: txtFieldLeftPaddingWidth)
       // _ = placeHolederLbl.setTrailingAnc(txtField.leadingAnchor, withConst: 0)
        placeHolderCenterYConstraint = placeHolederLbl.setCenterVerticalTo(txtField, withConst: 0)
        placeHolederLbl.heightAnchor.constraint(equalToConstant: placeHolderHeight).isActive = true
       
        if let txt = text {
            if txt.count > 0 {
                startEditing(text)
            }else{
                endEditingWithTxt("")
            }
        }
    }
    
    
    //MARK:- LeftIcon and TxtField
    
    @IBInspectable var iconSize : CGFloat = 20.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var logoImg : UIImage? = nil{
        didSet{
            iconImgView.image = logoImg
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var text : String? {
        set{
            txtField.text = newValue
            if newValue?.count == 0 {
                placeHolderCenterYConstraint?.constant = 0
                txtField.textColor = textColor
                underlineView.backgroundColor = underLineViewColor
                iconImgView.renderImgWithColor(underLineViewColor)
                endEditingWithTxt(newValue ?? "")
            }else{
                iconImgView.renderImgWithColor(textColor)
                txtField.textColor = textColor
                underlineView.backgroundColor = underLine_Hilight_ViewColor
                placeHolderCenterYConstraint?.constant = -((txtField.frame.size.height/2)+spacing+placeHolderHeight/2)
                startEditing(newValue)
            }

        }
        get{
            return txtField.text
        }
    }
    @IBInspectable var textColor : UIColor {
        set{
            txtField.textColor = newValue
            self.setNeedsDisplay()
        }
        get{
            return txtField.textColor ?? UIColor.black
        }
    }
   
    
    @IBInspectable var keyboardType : UIKeyboardType = .default {
        didSet{
            txtField.keyboardType = keyboardType
        }
    }
    
    @IBInspectable var inputAccessoryView1 : UIView? {
        didSet{
            txtField.inputAccessoryView = self.inputAccessoryView1
        }
    }
    
    func addLeftImgAndTxtField() -> Void { // dependence eachother
        self.addSubview(iconImgView)
        self.addSubview(txtField)

        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        iconImgView.image = logoImg
        iconImgView.renderImgWithColor(underLineViewColor)
        _ = iconImgView.setLeadingAnc(self.leadingAnchor, withConst: spacing)
        iconImgView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iconImgView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
       
        
        txtField.delegate = self
        txtField.placeholder = ""
//        txtField.backgroundColor = UIColor.green
        txtField.translatesAutoresizingMaskIntoConstraints = false
        _ = txtField.setTrailingAnc(self.trailingAnchor, withConst: spacing)
        _ = txtField.setTopAnc(self.topAnchor, withConst: placeHolderHeight + spacing)
        _ = txtField.setBottomAnc(underlineView.topAnchor, withConst: spacing)
        _ = iconImgView.setCenterVerticalTo(txtField, withConst: 0)
        _ = txtField.setLeadingAnc(iconImgView.trailingAnchor, withConst: spacing)
        setPaddingView()
    }
    
    
    
    //MARK:- Underline View
    
    @IBInspectable var underLineViewColor : UIColor = UIColor.lightGray{
        didSet{
            underlineView.backgroundColor = underLineViewColor
        }
    }
    @IBInspectable var underLine_Hilight_ViewColor : UIColor = UIColor.lightGray{
        didSet{
           // underlineView.backgroundColor = underLine_Hilight_ViewColor
        }
    }
    @IBInspectable var underlineViewHeight : CGFloat = 1.5{
        didSet{
            _ = underlineView.heightAnchor.constraint(equalToConstant: underlineViewHeight).isActive = true
        }
    }
    func addUnderLineView() -> Void {
        self.addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = underLineViewColor
        _ = underlineView.setBottomAnc(warningLbl.topAnchor, withConst: spacing)
        _ = underlineView.setTrailingAnc(self.trailingAnchor, withConst: spacing)
        _ = underlineView.heightAnchor.constraint(equalToConstant: underlineViewHeight).isActive = true
        addLeftImgAndTxtField()
        _ = underlineView.setLeadingAnc(txtField.leadingAnchor, withConst: spacing)


    }

    
    //MARK:- WARNING LBL
    @IBInspectable var warningLblHeight : CGFloat = 10.0{
        didSet{
            _ = warningLbl.heightAnchor.constraint(equalToConstant: warningLblHeight).isActive = true
        }
    }
    @IBInspectable var warningLblTxtColor : UIColor = UIColor.red{
        didSet{
            warningLbl.textColor = warningLblTxtColor
        }
    }
    @IBInspectable var warningLblFont : UIFont = UIFont.systemFont(ofSize: 10){
        didSet{
            warningLbl.font = warningLblFont
        }
    }
    @IBInspectable var warningLblText: String = ""{
        didSet{
            warningLbl.text = warningLblText
        }
    }
    func addWarningLbl() -> Void {
        self.addSubview(warningLbl)
        warningLbl.translatesAutoresizingMaskIntoConstraints = false
        warningLbl.textColor = warningLblTxtColor
        warningLbl.text = warningLblText
        warningLbl.font = warningLblFont
//        warningLbl.textAlignment = NSTextAlignment.center
        _ = warningLbl.setBottomAnc(self.bottomAnchor, withConst: spacing)
        _ = warningLbl.setLeadingAnc(self.leadingAnchor, withConst: spacing)
        _ = warningLbl.setTrailingAnc(self.trailingAnchor, withConst: spacing)
        _ = warningLbl.heightAnchor.constraint(equalToConstant: warningLblHeight).isActive = true
    }
  
    
}
// MARK:- TxtField Delegate

extension FloatingTxtField:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if let bool = delegate?.floatingTxtFieldShouldBeginEditing?(self){
            if bool == true{
                UIView.animate(withDuration: 0.2) {
                    if textField.text?.count == 0{
                        self.startEditing(self.text)
                        self.layoutIfNeeded()
                    }
                }
            }
            return bool
        }else{
            return true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.floatingTxtFieldDidBeginEditing?(self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.floatingTxtFieldDidEndEditing?(self)

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.2) {
            self.endEditingWithTxt(textField.text!)
            self.layoutIfNeeded()
        }
        if let bool = delegate?.floatingTxtFieldShouldEndEditing?(self){
            return bool
        }else{
            return true
        }
        
    }
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        delegate?.floatingTxtFieldDidEndEditing?(self, reason: reason)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if let bool = delegate?.floatingTxtField?(self, shouldChangeCharactersIn: range, replacementString: string){
            return bool
        }else{
            return true
        }
        
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      
        if  let bool = delegate?.floatingTxtFieldShouldClear?(self){
            return bool
        }else{
            return true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return (delegate?.floatingTxtFieldShouldReturn?(self)) ?? true
    }

    func startEditing(_ txt :String?) -> Void{
            let font = placeHolederLbl.font
            placeHolederLbl.font = font?.withSize((font?.pointSize ?? 4) - 4)
            txtField.layoutIfNeeded()
            iconImgView.renderImgWithColor(textColor)
            txtField.textColor = textColor
            underlineView.backgroundColor = underLine_Hilight_ViewColor
            placeHolderCenterYConstraint?.constant = -((txtField.frame.size.height/2)+spacing+placeHolderHeight/2)

    }
    func endEditingWithTxt(_ txt : String) -> Void {
        
        
        if txt.count == 0 {
            placeHolederLbl.font = placeHolderLblFont
            placeHolderCenterYConstraint?.constant = 0
            txtField.textColor = textColor
            underlineView.backgroundColor = underLineViewColor
            iconImgView.renderImgWithColor(underLineViewColor)
        }
    }
    
}


extension UIImageView{
    func renderImgWithColor(_ imgColor : UIColor) -> Void{
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = imgColor
    }
}

extension FloatingTxtField{
    func setUpTxtField( _ txt : String ,font : UIFont, textColor : UIColor ,underLine_Hilight_ViewColor : UIColor,underLineViewColor : UIColor,placeHoleder : String,placeHolederLblFont : UIFont, placeholderTxtColor : UIColor, keyboardType : UIKeyboardType , delegate : FloatingTxtFieldDelegate?, logoImg : UIImage?,isSecureTextEntry : Bool,warningText:String?) -> Void {
        self.delegate = delegate
        self.txtField.keyboardType = keyboardType
        self.placeholderTxtColor = placeholderTxtColor
        self.placeHolederLbl.font = placeHolederLblFont
        self.placeHolderLblFont = placeHolederLblFont
        self.placeHoleder = placeHoleder
        self.underLineViewColor = underLineViewColor
        self.underLine_Hilight_ViewColor = underLine_Hilight_ViewColor
        self.textColor = textColor
        self.txtField.font = font
        self.txtField.text = txt
        self.text = txt
        endEditingWithTxt(txt)
        self.logoImg = logoImg
        warningLblText = warningText ?? ""
//        self.txtField.inputAccessoryView = inputAccessoryView
        self.txtField.autocorrectionType = .no
        setUpSecureEntry(isSecureTextEntry)
        
        
    }
    func setUpSecureEntry(_ isSecureTextEntry: Bool) -> Void {
        self.txtField.isSecureTextEntry = isSecureTextEntry

    }
    func makeFirstResponder() -> Void {
        txtField.becomeFirstResponder()
    }
}
