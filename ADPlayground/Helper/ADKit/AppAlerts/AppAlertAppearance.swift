//
//  BasicAlertAppearance.swift
//  VenomAlert
//
//  Created by Adel Radwan on 4/10/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit

struct AppAlertAppearance {
    
    var bgColor: UIColor  = AppColor.white.value
    
    var leftButtonBgColor: UIColor  = AppColor.lightGray.value
    var leftButtonFont: UIFont   = Fonts.cairo.semiBold.font(size: 16)
    var leftButtonColor: UIColor  = AppColor.darkBlue.value
    
    var rightButtonBgColor: UIColor  = AppColor.darkBlue.value
    var rightButtonFont: UIFont   = Fonts.cairo.semiBold.font(size: 16)
    var rightButtonColor: UIColor  = AppColor.white.value
    
    var messageColor: UIColor  = AppColor.darkGray.value
    var messageFont: UIFont   = Fonts.cairo.regular.font(size: 14)
    
    var titleColor: UIColor  = AppColor.darkBlue.value
    var titleFont : UIFont   = Fonts.cairo.semiBold.font(size: 16)
    
    var imageViewMode: UIView.ContentMode = .scaleAspectFit
    var imageColor: AppColor = .darkBlue
    
    
}
