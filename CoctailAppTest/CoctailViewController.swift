//
//  CoctailViewController.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 07.04.2022.
//

import UIKit
import SnapKit

final class CoctailViewController: UIViewController  {
    
    private var drinks = Drink()
    
    private let scrollView = UIScrollView()
    
    private let tagsCloud = TagsCloud()
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        networkService.getDrinks() { [weak self] drinks in
            self?.drinks = drinks
            guard let scrollView = self?.scrollView else { return }
            guard let drinks = self?.drinks else { return }
            self?.tagsCloud.createTagCloud(OnView: scrollView, withArray: drinks as Drink)
                            
            self?.tagsCloud.coctailNameTextField.textField.addTarget(self, action: #selector(self?.textFieldDidChange(_:)), for: .editingChanged)
        }
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupScrollView() {
        
        self.view.addSubview(self.scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: 6 * self.scrollView.bounds.height)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, Any> {
            if let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = keyboardFrameValue.cgRectValue
                
                let textFieldOriginPlusHeight = tagsCloud.coctailNameTextField.textField.frame.origin.y + tagsCloud.coctailNameTextField.textField.frame.size.height
                
                if textFieldOriginPlusHeight > keyboardFrameValue.cgRectValue.origin.y {
                    let overlappedSpace = (textFieldOriginPlusHeight - keyboardFrame.origin.y) / 22.0
                    
                    tagsCloud.coctailNameTextField.topConstraint?.update(offset: -overlappedSpace)
                    tagsCloud.coctailNameTextField.leftConstraint?.update(offset: 0.0)
                    tagsCloud.coctailNameTextField.rightConstraint?.update(offset: 0.0)
                    
                    tagsCloud.coctailNameTextField.textField.layer.cornerRadius = 0.0
                    
                    self.tagsCloud.coctailNameTextField.textField.setNeedsLayout()
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        self.tagsCloud.coctailNameTextField.textField.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        tagsCloud.coctailNameTextField.topConstraint?.update(offset: 20.0)
        tagsCloud.coctailNameTextField.leftConstraint?.update(offset: 40.0)
        tagsCloud.coctailNameTextField.rightConstraint?.update(offset: -40.0)
        
        tagsCloud.coctailNameTextField.setupTextField()

        self.tagsCloud.coctailNameTextField.textField.setNeedsLayout()

        UIView.animate(withDuration: 0.4, animations: {
            self.tagsCloud.coctailNameTextField.textField.layoutIfNeeded()
        })
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        drinks.drinks?.forEach {
            tagsCloud.textlable.setHighlighted($0.strDrink, with: textField.text ?? "")
        }
    }
}

