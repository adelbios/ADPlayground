//
//  ProfileTarget.swift
//  Ra7ty
//
//  Created by Adel Radwan on 05/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import Foundation
import Moya
import UIKit.UIImage

public enum Profile {
    
    case info
    
    case changeAvatar(image: UIImage)
    
    case changePassword(oldPassword: String, newPassword:String, confirmPassword: String)
    
    case updateMe(name: String, countryCode: String, phoneNumber: String, email: String)
   
}

extension Profile: TargetType  {
    
    public var baseURL: URL { return URL(string: AppNetwork.apiURL)! }
    
    public var headers: [String : String]? { return AppNetwork.headers }
    
    public var path: String {
        switch self {
        case .info:
            return "profile/info"
        case .changeAvatar:
            return "profile/change/image"
        case .changePassword:
            return "profile/change/password"
        case .updateMe:
            return "profile/update/me"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .info:
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
extension Profile {
    
    public var task: Task {
        switch self {
        case .info:
            return .normal
        case .changeAvatar(let image):
            let data = image.jpegData(compressionQuality: 0.6)!
            return .upload(data, fileName: "image")
        case .changePassword(let oldPassword, let newPassword, let confirmPassword):
            return .request(["old_password": oldPassword, "new_password": newPassword, "c_password": confirmPassword])
        case .updateMe(let name, let countryCode, let phoneNumber, let email):
            return .request(["name": name, "phone_number": phoneNumber.toEnglish, "country_code": countryCode, "email": email])
        }
    }
}
