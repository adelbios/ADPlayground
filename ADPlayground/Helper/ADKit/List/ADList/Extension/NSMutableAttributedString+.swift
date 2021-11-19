//
//  NSMutableAttributedString+.swift
//  Shour
//
//  Created by Adel Radwan on 05/11/2021.
//

import UIKit

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
         let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttributes([
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.strokeColor: AppColor.blue.value,
            NSAttributedString.Key.strokeWidth: 4,
        ], range: range)
      }

}
