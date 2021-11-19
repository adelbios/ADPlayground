//
//  TokenTarget.swift
//  Ra7ty
//
//  Created by Adel Radwan on 05/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import Foundation
import Moya


public enum HomeTarget {
    
    case getRealEstate(page: Int)
   
}

extension HomeTarget: TargetType  {
    
    public var baseURL: URL { return URL(string: AppNetwork.apiURL)! }
    
    public var headers: [String : String]? { return AppNetwork.headers }
    
    public var path: String {
        return "getRealEstates"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
}

//MARK: - Task
extension HomeTarget {
    
    public var task: Task {
        switch self {
        case .getRealEstate(let page):
            return .queryRequest(["page": page])
        }
    }
}
