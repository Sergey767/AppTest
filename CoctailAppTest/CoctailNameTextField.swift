//
//  CoctailNameTextField.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 10.04.2022.
//

import UIKit
import SnapKit

final class CoctailNameTextField {
    
    var textField = UITextField()
    
    var topConstraint: Constraint? = nil
    var leftConstraint: Constraint? = nil
    var rightConstraint: Constraint? = nil
    
    func setupCoctailNameTextField(OnView view: UIView, twoView: UIView) {
        
        setupTextField()
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            self.topConstraint = make.top.equalTo(twoView.snp.bottom).offset(20).constraint
            self.leftConstraint = make.left.equalTo(view).offset(40).constraint
            self.rightConstraint = make.right.equalTo(view).offset(-40).constraint
            make.height.equalTo(30)
        }
    }
    
    func setupTextField() {
        
        textField.placeholder = "Coctail name"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        textField.layer.cornerRadius = 13.0
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0.0
        textField.layer.masksToBounds = false
        textField.layer.borderColor = UIColor.white.cgColor
        
        setupShadowTextField()
    }
    
    private func setupShadowTextField() {
        
        textField.layer.shadowRadius = 7.0
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.shadowOpacity = 0.5
    }
}
