//
//  UIView.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import SkeletonView

extension UIView {
    
    func cardView(cornerRadius: CGFloat, shadowColor: UIColor = AppColor.gray.value, shadowRadius: CGFloat = 3,
                  shadowOpacity: Float = 0.3, shadowOffset: CGSize = CGSize(width: 0, height: 0)){
        layer.cornerRadius  = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor   = shadowColor.cgColor
        layer.shadowOffset  = shadowOffset
        layer.shadowRadius  = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.masksToBounds = false
    }
    
    func shake(repeatCount: Float = 2){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func setGradient(with colors: [UIColor], cornerRadius: CGFloat, shadowColor: UIColor = AppColor.lightGray.value,
                     shadowOffset: CGSize = CGSize(width: 2.5, height: 2.5),  shadowRadius: CGFloat = 5.0,
                     shadowOpacity: Float = 0.8)->CAGradientLayer {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = false
        gradientLayer.shadowColor   = shadowColor.cgColor
        gradientLayer.shadowOffset  = shadowOffset
        gradientLayer.shadowRadius  = shadowRadius
        gradientLayer.shadowOpacity = shadowOpacity
        gradientLayer.masksToBounds = false
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    func round(from corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.shadowColor   = AppColor.gray.value.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 0)
        layer.shadowRadius  = 0.3
        layer.shadowOpacity = 3
    }
    
    func addDashedBorder(with color: AppColor) {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.value.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
}

//MARK: - Layer
extension UIView {
    
    
    @discardableResult func addBorder(with edges: UIRectEdge, color: UIColor = AppColor.black.value, thickness: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
}

//MARK: - BaseView
class BaseView : UIView {
    
    var useNormalPassValidation:Bool {
        return true
    }
    
    var didPassValidation:(()->())?
    
    var didFaildValidation:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableSkeletoneFor(_ views: [UIView]){
        views.forEach {
            $0.isSkeletonable = true
        }
    }
    
    @objc dynamic func setupViews(){ self.backgroundColor = AppColor.white.value }
    
    @objc dynamic func setupSettings(){}
    
    @objc dynamic func settingsForSuccessValidation(){}
    
    @objc dynamic func settingsForErrorValidation(){}
    
}
