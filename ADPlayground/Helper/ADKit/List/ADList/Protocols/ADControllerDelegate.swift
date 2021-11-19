//
//  ADControllerDelegate.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import UIKit

protocol ADControllerDelegate: AnyObject {
    func heightForItem(at: IndexPath, model: ADBindable) -> CGFloat
}
