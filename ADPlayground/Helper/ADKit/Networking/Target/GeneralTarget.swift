//
//  GeneralTarget.swift
//  Ra7ty
//
//  Created by Adel Radwan on 05/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import Foundation
import Moya


public enum General {
 
    case countries
    
    case city(countryId: Int)
    
    case chaletTypes
    
    case chaletContent
    
    case allCity
 
}

extension General: TargetType  {
    
    public var baseURL: URL { return URL(string: AppNetwork.apiURL)! }
    
    public var headers: [String : String]? { return AppNetwork.headers }
    
    public var path: String {
        switch self {
        case .countries:
            return "country/all"
        case .city(let countryId):
            return "country/\(countryId)/get"
        case .chaletTypes:
            return "chalet/types"
        case .chaletContent:
            return "chalet/contents"
        case .allCity:
            return "city/all"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
}

//MARK: - Task
extension General {
    
    public var task: Task {
        switch self {
        case .countries:
            return .normal
        case .city(_):
            return .normal
        case .chaletTypes:
            return .normal
        case .chaletContent:
            return .normal
        case .allCity:
            return .normal
        }
    }
}
