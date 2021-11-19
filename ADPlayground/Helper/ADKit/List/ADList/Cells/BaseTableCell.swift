//
//  BaseTableCell.swift
//  Shour
//
//  Created by Adel Radwan on 10/11/2021.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    //MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    func setupViews(){}
    
    func enableSkeletoneFor(_ views: [UIView]){
        views.forEach {
            $0.isSkeletonable = true
        }
    }
    
}
