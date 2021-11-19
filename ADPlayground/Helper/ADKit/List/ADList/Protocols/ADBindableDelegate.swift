//
//  ADBindableDelegate.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import UIKit

private protocol ADBindableDelegate {
    static var cellId: String { get }
    func configure(cell: UIView)
}

class ADBindable: ADBindableDelegate, Hashable {
    
    class var cellId: String {
        return ""
    }
    
    func configure(cell: UIView) {}
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: ADBindable, rhs: ADBindable) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
