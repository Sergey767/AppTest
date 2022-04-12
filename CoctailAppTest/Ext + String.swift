//
//  Ext + String.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 08.04.2022.
//

import Foundation
import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
