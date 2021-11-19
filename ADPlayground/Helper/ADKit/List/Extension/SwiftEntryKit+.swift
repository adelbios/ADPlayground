//
//  SwiftEntryKit+.swift
//  JUSUR
//
//  Created by Adel Radwan on 2/7/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//
import UIKit
import SwiftEntryKit

extension SwiftEntryKit{
        
    static func showInAppNotification(
        _ alert:UIView,
        entranceAnimation: EKAttributes.Animation = .init(translate: .none, scale: .none, fade: .init(from: 0, to: 1, duration: 0.3)),
        exitAnimation: EKAttributes.Animation = .init(translate: .none, scale: .none, fade: .init(from: 1, to: 0, duration: 0.2)),
        position: EKAttributes.Position = .bottom, isUseTabBar: Bool, statusBar: EKAttributes.StatusBar, duration: Double = 8,
        didDisappear:@escaping()->() = {}
    ){
        
        var attributes                   = EKAttributes()
        attributes.entryInteraction    = .forward
        attributes.screenInteraction   = .forward
        attributes.entranceAnimation   = entranceAnimation
        attributes.exitAnimation       = exitAnimation
        attributes.position            = position
        attributes.hapticFeedbackType = .none
        let widthConstraint            = EKAttributes.PositionConstraints.Edge.constant(value: UIScreen.main.bounds.width - 40)
        let heightConstraint           = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.displayDuration     = EKAttributes.DisplayDuration(duration)
        attributes.statusBar           = statusBar
        attributes.precedence          = .enqueue(priority: .normal)
        if isUseTabBar { attributes.positionConstraints.verticalOffset = UITabBarController().tabBar.frame.size.height }
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.lifecycleEvents = .init( didDisappear: { didDisappear() })
        SwiftEntryKit.display(entry: alert, using: attributes,presentInsideKeyWindow: true)
        
    }
    
    static func showAppAlertForView(
        _ alert:UIView,
        position: EKAttributes.Position = .center,
        hapticFeedback: EKAttributes.NotificationHapticFeedback = .warning,
        didDisappear: @escaping()->() = {}
    ){

        var attributes                  = EKAttributes()
        attributes.entryInteraction     = .forward
        attributes.screenInteraction    = .dismiss
        attributes.entranceAnimation    = .init(translate: .none, scale: nil, fade: .init(from: 0, to: 1, duration: 0.5))
        attributes.exitAnimation        = .init(translate: EKAttributes.Animation.Translate.init(duration: 0.3), scale: nil, fade: nil)
        attributes.hapticFeedbackType   = hapticFeedback
        attributes.screenBackground     = .color(color: EKColor(UIColor.black.withAlphaComponent(0.7)))
        attributes.position             = position
        attributes.statusBar            = .dark
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.name                 = ""
        let widthConstraint             = EKAttributes.PositionConstraints.Edge.constant(value: UIScreen.main.bounds.width - 40)
        let heightConstraint            = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.displayDuration      = .infinity
        attributes.precedence           = .enqueue(priority: .normal)
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.lifecycleEvents = .init(didDisappear: { didDisappear() })
        SwiftEntryKit.display(entry: alert, using: attributes)
        
    }
}
