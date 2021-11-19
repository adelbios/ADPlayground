//
//  UIDevice+.swift
//  Que
//
//  Created by Adel Radwan on 9/14/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var hasNotch: Bool {
       let bottom = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0})
        .first?.windows.filter({$0.isKeyWindow}).first?.rootViewController?.view.safeAreaInsets.bottom ??  0
        return bottom > 0
    }
}
