//
//  VenomCellActions.swift
//  VenomListKit
//  Use this article https://medium.com/chili-labs/handling-cell-actions-with-swift-generics-97604926a495
//  Created by Adel Radwan on 5/5/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit

enum ADCellsAction: Hashable {
    
    case didSelect
    case didDeSelect
    case custom(String)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .didSelect    : hasher.combine(1)
        case .didDeSelect  : hasher.combine(2)
        case .custom(let custom): hasher.combine(custom)
        }
    }
    
    public static func ==(lhs: ADCellsAction, rhs: ADCellsAction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension ADCellsAction {
    
    static let notificationName = NSNotification.Name(rawValue: "ADCellActions")
    
    public func invoke(cell: UIView) {
        NotificationCenter.default.post(name: ADCellsAction.notificationName, object: nil, userInfo: ["data": ADCellActionModel(action: self, cell:cell)])
    }
}




