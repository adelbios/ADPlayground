//
//  UIImageView.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageWith(_ urlString:String){
        guard let url = URL(string: urlString) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil) { _ in
        }
    }
    
}

extension UIImage {
    
    var toData:Data {
        return self.jpegData(compressionQuality: 1) ?? Data()
    }
    
    func toData(with quality: CGFloat) -> Data{
        return self.jpegData(compressionQuality: quality) ?? Data()
    }
    
    func getCropRatio()->CGFloat{
        let widthRatio = self.size.width / self.size.height
        return widthRatio
    }
}

