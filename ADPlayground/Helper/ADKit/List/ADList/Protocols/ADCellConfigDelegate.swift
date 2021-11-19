//
//  ADCellConfigDelegate.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import UIKit

protocol ADCellConfigDelegate {
    static var reuseIdentifier: String { get }
    associatedtype DataType
    func configure(data: DataType)
}

extension ADCellConfigDelegate {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}
