//
//  VenomCellActionProxy.swift
//  JUSUR
//
//  Created by Adel Radwan on 5/6/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit
import Combine

class ADActionProxy {
    
    private var actions = [String: ((ADBindable, UIView) -> Void)]()
    
    func invoke(action: ADCellsAction, cell: UIView, configurator: ADBindable) {
        let key = "\(action.hashValue)\(type(of: configurator).cellId)"
        guard let action = self.actions[key] else { return }
        action(configurator, cell)
        
    }
    
    @discardableResult
    func on<CellType, DataType>(_ action: ADCellsAction, handler: @escaping ((ADCell<CellType, DataType>) -> Void)) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { list, _ in
            handler(list as! ADCell<CellType, DataType>)
        }
        return self
    }
    
//    @discardableResult
//    func on<CellType, DataType>(_ action: ADCellsAction, handler: @escaping ((ADTableCell<CellType, DataType>) -> Void)) -> Self {
//        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
//        self.actions[key] = { list, _ in
//            handler(list as! ADTableCell<CellType, DataType>)
//        }
//        return self
//    }
}
