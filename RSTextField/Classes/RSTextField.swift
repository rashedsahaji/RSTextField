//
//  RSTextField.swift
//  RSTextField
//
//  Created by Big oh on 01/05/22.
//

import Foundation
import UIKit

enum rightSideButtonType:String {
    case edit = "edit"
    case show = "show"
}

class RSTextField: UITextField {
    private let button = UIButton(type: .custom)
    
    //Set Custom Placeholder Colors
    var placeholderColor:UIColor?{
        didSet{
            self.setPlaceholderColor()
        }
    }
    
    private func setPlaceholderColor(){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor ?? UIColor.lightGray])
    }
    
    //Set Right Side Button Edit or Show/Hide Password
    var setRightView:rightSideButtonType? {
        didSet {
            self.setupRightView()
        }
    }
    var setRightViewButtonFont:UIFont?
    
    private func setupRightView(){
        switch self.setRightView {
        case .show:
            button.frame = CGRect(x: CGFloat((self.frame.size.width) - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
            button.setAttributedTitle(NSAttributedString(string: "Show", attributes: [NSAttributedString.Key.font : setRightViewButtonFont ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
            button.addTarget(self, action: #selector(toggleSecuretext), for: .touchUpInside)
            self.rightView = button
            self.rightViewMode = .always
            
        case .edit:
            button.frame = CGRect(x: CGFloat((self.frame.size.width) - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
            button.setAttributedTitle(NSAttributedString(string: "Edit", attributes: [NSAttributedString.Key.font : setRightViewButtonFont ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
            button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
            self.rightView = button
            self.rightViewMode = .always
        case .none:
            break
        }
    }
    
    @objc func toggleSecuretext() {
        if self.isSecureTextEntry {
            self.isSecureTextEntry = false
            button.setAttributedTitle(NSAttributedString(string: "Hide", attributes: [NSAttributedString.Key.font : setRightViewButtonFont ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
        } else {
            self.isSecureTextEntry = true
            button.setAttributedTitle(NSAttributedString(string: "Show", attributes: [NSAttributedString.Key.font : setRightViewButtonFont ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
        }
    }
    @objc func didTapEdit(){
        self.becomeFirstResponder()
        self.selectAll(nil)
    }
    
    // Custom Padding for Placeholder \\ Text \\ Editting
    private let defaultPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var placeholderPadding: UIEdgeInsets?
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderPadding ?? defaultPadding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

