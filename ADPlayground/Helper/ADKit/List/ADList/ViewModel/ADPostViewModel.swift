//
//  PostViewModel.swift
//  Emirates motors
//
//  Created by Adel Radwan on 15/03/2021.
//

import UIKit
import Combine

class ADPostViewModel: NSObject {
        
    //MARK: - Variables
    let network  = AppNetwork()
    
    let json = JSONDecoder()
    
    private var subscription = Set<AnyCancellable>()
    
    private var ignoreNetworkErrorAlert = false
    
    //MARK: - Life cycle
    required override init() {
        super.init()
        didSuccessFetchData()
        observeNetworkError()
    }
    
    //MARK: - makeHTTPRequest
    func request(at view: UIView? = nil){
        if let view = view {
            view.endEditing(true)
            ignoreNetworkErrorAlert = false
        }else{
            ignoreNetworkErrorAlert = true
        }
        
    }
    
    //MARK: - DidSuccses to fetch data
    func didSuccessWith(_ data: Data) { }
    
    private func didSuccessFetchData(){
        network.$data
            .compactMap { $0 } // to remove nil value & first lunsh when data is Empty
            .removeDuplicates()
            .sink { [weak self] data in
                guard let self = self else { return }
                DispatchQueue.main.async { self.didSuccessWith(data) }
            }.store(in: &subscription) // Store subscripton to cancelled when dienit calling
    }
    
    //MARK: - NetworkError
    private func observeNetworkError(){
        network.$networkErrorModel
            .compactMap{ $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                guard self.ignoreNetworkErrorAlert == false else { return }
                DispatchQueue.main.async { self.network.showNoInternetConnectionAlert(with: model.msg) }
            }.store(in: &subscription)
    }
    
}

