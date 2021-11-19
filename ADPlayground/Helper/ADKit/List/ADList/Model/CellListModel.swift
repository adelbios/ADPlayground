//
//  CellListModel.swift
//  Shour
//
//  Created by Adel Radwan on 28/09/2021.
//

import UIKit

struct CellListModel {
    
    let cell: UITableViewCell.Type
    let fromNib: Bool
    let skeletonModel: ADLoadingModel?
    
    init(_ cell: UITableViewCell.Type, fromNib: Bool = false, skeletonModel: ADLoadingModel? = nil) {
        self.cell = cell
        self.fromNib = fromNib
        self.skeletonModel = skeletonModel
    }
}
