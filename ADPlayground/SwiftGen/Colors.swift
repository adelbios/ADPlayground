//
//  Colors.swift
//
//  Created by Adel Radwan
//
import UIKit

@objc public enum AppColor: Int {

  public var rawValue: Int { return 1 }

   case background 
   case black 
   case blue 
   case darkBlue 
   case darkGray 
   case gray 
   case green 
   case lightGray 
   case red 
   case white 
   case clear

}

 extension AppColor {


   var value: UIColor {
        get {
            return value(alpha: 1)
        }
    }

  func value(alpha: CGFloat = 1)-> UIColor {
    switch self {
         case .background:
            return UIColor(named: "AppBackground")!.withAlphaComponent(alpha)
         case .black:
            return UIColor(named: "AppBlack")!.withAlphaComponent(alpha)
         case .blue:
            return UIColor(named: "AppBlue")!.withAlphaComponent(alpha)
         case .darkBlue:
            return UIColor(named: "AppDarkBlue")!.withAlphaComponent(alpha)
         case .darkGray:
            return UIColor(named: "AppDarkGray")!.withAlphaComponent(alpha)
         case .gray:
            return UIColor(named: "AppGray")!.withAlphaComponent(alpha)
         case .green:
            return UIColor(named: "AppGreen")!.withAlphaComponent(alpha)
         case .lightGray:
            return UIColor(named: "AppLightGray")!.withAlphaComponent(alpha)
         case .red:
            return UIColor(named: "AppRed")!.withAlphaComponent(alpha)
         case .white:
            return UIColor(named: "AppWhite")!.withAlphaComponent(alpha)
         case .clear:
            return UIColor.clear
    }
  }

}
