//
//  Networking.swift
//  JUSUR
//
//  Created by Adel Radwan on 12/10/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import Reachability

@objc protocol NetworkReachabilityDelegate: AnyObject {
    @objc dynamic func isReachableToTheInternet(_ val:Bool)
}

class ADNetworkReachability {
    
    private var reachability: Reachability?
    
    private let hostNames = "google.com"
    
    weak var delegate: NetworkReachabilityDelegate?
    
    func startHostObservation() {
        stopHostObservation()
        setupReachability()
        startNotifier()
    }
    
    func stopHostObservation() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    private func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    private func setupReachability() {
        let reachability: Reachability?
        reachability = try! Reachability(hostname: self.hostNames)
        self.reachability = reachability
        
        reachability?.whenReachable = { [weak self] reachability in
            guard let self = self else { return }
            self.delegate?.isReachableToTheInternet(true)
        }
        reachability?.whenUnreachable = { [weak self] reachability in
            guard let self = self else { return }
            self.delegate?.isReachableToTheInternet(false)
        }
    }
    
}



