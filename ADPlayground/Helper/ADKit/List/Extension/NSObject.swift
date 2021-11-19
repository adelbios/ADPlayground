//
//  NSObject.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit

extension NSObject {
    
    class var name: String { return String(describing: self) }
    
    var className : String { return String(describing: self).components(separatedBy: ":")[0] }
    
    func dateFormatter(with date: Date)-> String {
        let formatter = DateFormatter()
        formatter.locale   = .current
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}




