//
//  ApiRequest.swift
//  Shour
//
//  Created by Adel Radwan on 30/06/2021.
//

import UIKit
import Moya
import JGProgressHUD
import Combine


class AppNetwork: ADNetwork {
    
    override class var baseURL: String {
        return "https://estates-jazan.com/"
    }
    
    override class var headers: [String : String] {
        return [:]
    }
    
    static var apiURL: String {
        return  "\(baseURL)api/v2/"
    }
    
    override func showNoInternetConnectionAlert(with msg: String) {
        let message = msg.isEmpty ? L10n.NoInternet.title : msg
        let alert = AppAlert(image: Asset.Alert.error.name, msg: message)
        DispatchQueue.main.async { alert.show() }
    }
}
