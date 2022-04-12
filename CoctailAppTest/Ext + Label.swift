//
//  Ext + Label.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 12.04.2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func setHighlighted(_ text: String, with search: String) {
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: search, options: .caseInsensitive)
        let highlightColor = traitCollection.userInterfaceStyle == .light ? UIColor.systemYellow : UIColor.systemOrange
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: highlightColor]
        
        attributedText.addAttributes(highlightedAttributes, range: range)
        self.attributedText = attributedText
    }
}
