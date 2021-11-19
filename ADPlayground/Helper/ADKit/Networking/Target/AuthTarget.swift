//
//  AuthTarget.swift
//  hawlik
//
//  Created by Adel Radwan on 31/03/2021.
//

import Foundation
import Moya


public enum AuthTarget {
    
    case registration(isOwner: Bool, name: String, phoneNumber: String, countryCode: String, password: String, confirmPassword: String)
        
    case checkData(email: String?, countryCode: String, phoneNumber: String)
    
    case login(countryCode: String, phoneNumber: String, password: String)
    
    case resetPassword(countryCode: String, phoneNumber: String, password: String)
    
    case logout
}

extension AuthTarget: TargetType  {
    
    public var baseURL: URL { return URL(string: AppNetwork.apiURL)! }
    
    public var headers: [String : String]? { return AppNetwork.headers }
    
    public var path: String {
        switch self {
        case .registration(isOwner: let val, _, _, _, _, _):
            return val ? "auth/register/owner" : "auth/register/client"
        case .checkData:
            return "auth/data/check"
        case .login:
            return "auth/login"
        case .resetPassword:
            return "auth/reset/password"
        case .logout:
            return "auth/logout"
            
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return Data()
    }
    
}

//MARK: - Task
extension AuthTarget {
    
    public var task: Task {
        
        switch self {
            
            //MARK: - owner Registration
        case .registration(_, name: let n, phoneNumber: let p, countryCode: let c, password: let pass, confirmPassword: let cPass):
            return .request(["name": n, "phone_number": p, "country_code": c, "password": pass, "c_password": cPass])
        
            //MARK: - check Data
        case let .checkData(email: email, countryCode: code, phoneNumber: phone):
            let parm = ["email": email, "country_code": code, "phone_number": phone]
            return .request(parm.compactMapValues({ $0 }))
            
            //MARK: - Login
        case let .login(countryCode: code, phoneNumber: phone, password: pass):
            return .request(["country_code": code, "phone_number": phone, "password": pass, "type_login":2])
            
            //MARK: - reset Password
        case let .resetPassword(countryCode: code, phoneNumber: phone, password: pass):
            return .request(["country_code": code, "phone_number": phone, "password": pass, "type_login":2])
            
        case .logout:
            return .normal
            
        }//End swithch
    }
}
