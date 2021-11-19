//
//  HomeModel.swift
//  ADPlayground
//
//  Created by Adel Radwan on 19/11/2021.
//

import Foundation

struct HomeModel: Codable {
    let data: HomeDataModel
    
    //MARK: - HomeDataModel
    struct HomeDataModel: Codable {
        let currentPage: Int
        let lastPage: Int
        let items: [Item]
    }

    //MARK: - Item
    struct Item: Codable, Hashable {
        let id: Int
        let realEstateTitle, area, description: String
        let cityName: String
        let firstImg: String
    }
    
}


