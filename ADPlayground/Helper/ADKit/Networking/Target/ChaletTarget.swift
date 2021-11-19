//
//  ChaletTarget.swift
//  Ra7ty
//
//  Created by Adel Radwan on 05/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import Foundation
import Moya
import UIKit.UIImage
import CoreLocation

public enum Chalet {
    
    case index(page: Int)
    
    case chaletInfo(id: Int)
    
    case store(
        name: String, address: String, desc: String, peopleCount: Int, space: String, typeId: Int, price: String,
        content: [Int], media: [UIImage], location: CLLocationCoordinate2D
    )
    
    case edit(
        chaletId: Int, name: String, address: String, desc: String, peopleCount: Int,
        space: String, typeId: Int, content: [Int], media: [UIImage]
    )
   
}

extension Chalet: TargetType  {
    
    public var baseURL: URL { return URL(string: AppNetwork.apiURL)! }
    
    public var headers: [String : String]? { return AppNetwork.headers }
    
    public var path: String {
        switch self {
        case .index:
            return "owner/chalet"
        case .chaletInfo(id: let id):
            return "owner/chalet/\(id)"
        case .store:
            return "owner/chalet/add"
        case .edit(chaletId: let id, _, _, _, _, _, _, _, _):
            return "owner/chalet/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .index, .chaletInfo:
            return .get
        default:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
}

//MARK: - Task
extension Chalet {
    
    public var task: Task {
        switch self {
        case let .index(page: page):
            return .queryRequest(["page": page])
        case .chaletInfo(_):
            return .normal
        case let .store(
            name: name, address: address, desc: desc, peopleCount: count, space: space,
            typeId: id, price: price, content: content, media: files, location: loc
        ):
            let parms: [String: Any] = [
                "name": name, "address": address, "desc": desc, "people_count": count,
                "space": space, "type_id": id, "content_": content, "price": "\(price)",
                "lat": "\(loc.latitude)", "long": "\(loc.longitude)", "city_id": 1, "level_star": 2
            ]
            let mediaData = files.map { $0.jpegData(compressionQuality: 0.6) }.compactMap { $0 }

            return .uploadFiles(files: mediaData, fileName: "media[]", parms: parms)
            
        case .edit(_, name: let name, address: let address, desc: let desc, peopleCount: let count, space: let space, typeId: let id, content: let content, media: let files):
            let parms: [String: Any] = [
                "name": name, "address": address, "desc": desc, "people_count": count,
                "space": space, "type_id": id, "content": content
            ]
            let mediaData = files.map { $0.jpegData(compressionQuality: 0.6) }.compactMap { $0 }
            return .uploadFiles(files: mediaData, fileName: "media", parms: parms)
            
        }
    }
}
