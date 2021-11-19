//
//  EmptyViewAppearance.swift
//  Ra7ty
//
//  Created by Adel Radwan on 06/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import UIKit


struct EmptyViewAppearance {
    
    let color = ColorAppearance()
    
    let font = FontAppearance()
    
    let alignment = AlignmentAppearance()
    
    struct AlignmentAppearance {
        let full: NSTextAlignment  = .center
        let small: NSTextAlignment = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight ? .left : .right
    }

    struct ColorAppearance {
        var title                  = AppColor.black.value
        var message                = AppColor.blue.value
        var actionTitle            = AppColor.white.value
        var actionBackground       = AppColor.blue.value
        var holderView             = AppColor.white.value
    }

    struct FontAppearance {
        var title        = Fonts.cairo.bold.font(size: 22)
        var smallTitle   = Fonts.cairo.bold.font(size: 16)
        var message      = Fonts.cairo.regular.font(size: 16)
        var smallMessage = Fonts.cairo.regular.font(size: 14)
        var actionFont   = Fonts.cairo.bold.font(size: 16)
    }
    
}

