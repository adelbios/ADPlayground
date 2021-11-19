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

class ADNetwork: NSObject {
    
    enum RequestStatus { case loading, finished }
    
    //MARK: - Combine variable
    private var subscription = Set<AnyCancellable>()
    
    @Published private(set) var data: Data?
    
    @Published private(set) var networkErrorModel: ADNetworkErrorModel?
    
    @Published private(set) var requestStatus: RequestStatus = .finished // loading => request has been started, finished => request was ended
    
    //MARK: - Variable area
    let provider = MoyaProvider<MultiTarget>()
    
    private var networkingStatus = ADNetworkReachability()
        
    private let loading = JGProgressHUD(style: .extraLight)
    
    private(set) var isReachable: Bool = true
    
    //MARK: - Network variable
    class var baseURL: String { return "" }
    
    class var headers: [String : String]{ return [:] }
    
    //MARK: - Request
    internal func request(_ target: TargetType, at view: UIView? = nil){
        if let  view = view { self.loading.show(in: view, animated: true) }
        guard self.requestStatus == .finished else { return }
        self.requestStatus = .loading
        provider
            .requestPublisher(.target(target), callbackQueue: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] completion in
                guard let self = self else { return }
                guard case let .failure(error) = completion else { return }
                self.failure(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.success(response, target: target)
            }.store(in: &subscription)
    }
    
    func showNoInternetConnectionAlert(with msg: String){
        log(type: .warning, "TODO: don't forgot add alert")
    }
    
    func showUnauthenticatedMessage(){
        self.requestStatus = .finished
    }
    
    func ignoreNetworkRequest(){
        self.requestStatus = .finished
    }
}

//MARK: - Moya Success
private extension ADNetwork {
    
    func success(_ response: Response, target: TargetType){
        self.loading.dismiss(animated: true)
        log(type: .success, target, response.data.toJSON())
        guard response.statusCode != 401 else { showUnauthenticatedMessage(); return }
        self.data = response.data
        self.requestStatus = .finished
    }
    
}

//MARK: - Moya Error
private extension ADNetwork {
    
    func failure(_ moyaError : MoyaError){
        self.loading.dismiss(animated: true)
        self.networkErrorModel = ADNetworkErrorModel(statusCode: moyaError.errorCode, msg: moyaError.localizedDescription)
        self.requestStatus = .finished
    }
    
}

//MARK: - NetworkingDelegate
extension ADNetwork: NetworkReachabilityDelegate {
    
    func ObservationReachability(){
        networkingStatus.delegate = self
        networkingStatus.startHostObservation()
    }
    
    func terminateReachabilityObservation(){
        networkingStatus.stopHostObservation()
    }
    
    func isReachableToTheInternet(_ val: Bool) {
        isReachable = val
    }
    
}
