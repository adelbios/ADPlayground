//
//  Moya+.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import Moya


extension Task {
    
    static func request(_ parms: [String: Any])-> Task {
        return .requestParameters(parameters: parms, encoding: JSONEncoding.default)
    }
    
    static func queryRequest(_ parms: [String: Any])-> Task {
        return .requestParameters(parameters: parms, encoding: URLEncoding.queryString)
    }
    
    static func uploadFiles(files: [Data], fileName: String, parms: [String: Any]) -> Task {
        switch files.isEmpty {
        case true:
            return .request(parms)
        case false:
            let datafileModel = files.map {
                MultipartFormData(provider: .data($0), name: fileName, fileName: "\(fileName).jpeg", mimeType: "\(fileName)/jpeg")
            }
            return .uploadCompositeMultipart(datafileModel, urlParameters: parms)
        }
    }
    
    static func upload(_ file:Data, fileName: String)->Task {
        let fileData = MultipartFormData(provider: .data(file), name: fileName, fileName: "\(fileName).jpeg", mimeType: "\(fileName)/jpeg")
        return .uploadCompositeMultipart([fileData], urlParameters: [:])
    }
    
    static var normal: Task {
        return .requestPlain
    }
    
}

private  extension String {
    var toData: Data {
        return self.data(using: String.Encoding.utf8) ?? Data()
    }
}
