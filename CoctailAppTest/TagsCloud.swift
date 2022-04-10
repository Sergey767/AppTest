//
//  TagsCloud.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 08.04.2022.
//

import Foundation
import UIKit
import SnapKit

class TagsCloud {
    
    func createTagCloud(OnView view: UIScrollView, withArray data: Drink) {
        
        var xPos:CGFloat = 15.0
        var yPos: CGFloat = 30.0
        var tag: Int = 1
        
        data.drinks?.forEach {
            
            let startstring = $0.strDrink 
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 15.0) ?? UIFont.boldSystemFont(ofSize: 15.0))
            
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5)
            
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                
                xPos = 15.0
                yPos = yPos + 29.0 + 8.0
            }
            
            let bgView = UIView()
            view.addSubview(bgView)
            bgView.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(xPos)
                make.top.equalToSuperview().inset(yPos)
                make.width.equalTo(width + 17.0 + 38.5)
                make.height.equalTo(29.0)
            }
            
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = UIColor(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0)
            bgView.tag = tag
            
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.someAction(_:)))
            bgView.addGestureRecognizer(gesture)
            
            let textlable = UILabel()
            bgView.addSubview(textlable)
            textlable.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(0.0)
                make.height.equalToSuperview().inset(bgView.frame.size.height)
            }
            
            textlable.font = UIFont(name: "verdana", size: 15.0)
            textlable.text = $0.strDrink
            textlable.textColor = UIColor.white
            
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
            tag = tag  + 1
        }
    }
    
    @objc func someAction(_ sender: UITapGestureRecognizer) {
        sender.view?.backgroundColor = UIColor(red: 236.0/255.0, green: 99.0/255.0, blue: 192.0/255.0, alpha: 1.0)
    }
}
