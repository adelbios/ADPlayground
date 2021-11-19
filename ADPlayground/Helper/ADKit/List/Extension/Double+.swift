//
//  Double+.swift
//  JUSUR
//
//  Created by Adel Radwan on 5/4/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
