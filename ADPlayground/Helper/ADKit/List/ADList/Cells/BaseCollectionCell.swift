//
//  UICollectionView+.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import CRRefresh
import SkeletonView



class BaseCollectionCell: UICollectionViewCell {
    
    //MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews(){}
    
    func enableSkeletoneFor(_ views: [UIView]){
        views.forEach {
            $0.isSkeletonable = true
        }
    }
    
}

class BaseHeaderCell: UICollectionReusableView {
    
    //MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews(){}
    
    func enableSkeletoneFor(_ views: [UIView]){
        views.forEach {
            $0.isSkeletonable = true
        }
    }
    
}

