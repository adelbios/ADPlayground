//
//  SpinnerModel.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import Foundation

struct SpinnerModel: Codable, Hashable {
    var currentPage: Int
    var lastPage: Int
    var isLoadMoreEnable: Bool
}
