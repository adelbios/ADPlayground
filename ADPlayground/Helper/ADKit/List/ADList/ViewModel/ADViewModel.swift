//
//  ADViewModel.swift
//  Shour
//
//  Created by Adel Radwan on 18/09/2021.
//

import UIKit
import Combine

class ADViewModel<T: Codable>: NSObject {
    
    //MARK: - Variables
    let network  = AppNetwork()
    
    let json = JSONDecoder()
    
    private(set) var isInitalBinding = true
    
    private(set) var isStaticList = false
    
    private(set) var spinnerModel = SpinnerModel(currentPage: 1, lastPage: 1, isLoadMoreEnable: false)
     
    //MARK: - Combibne Variables
    private var subscription = Set<AnyCancellable>() // to cancel the subscription when dient was calling
    
    @Published private(set) var items: [ADBindable] = [ADBindable]() // Cell With models
    
    //MARK: - Life cycle
    required override init() {
        super.init()
        didSuccessFetchData()
    }
    
    //MARK: - makeHTTPRequest
    func makeHTTPRequest(){
        self.spinnerModel.isLoadMoreEnable = false
        self.isInitalBinding  = true
        self.isStaticList = false
    }
    
    //MARK: - fetch static data
    func fetchStaticData(){
        self.spinnerModel.isLoadMoreEnable = false
        self.isInitalBinding  = true
        self.isStaticList = true
        self.network.ignoreNetworkRequest()
    }
    
    //MARK: - Pagging request
    func fetchMoreRequest(){
        self.spinnerModel.isLoadMoreEnable = true
    }
    
    func loadMoreData(_ distance: CGFloat) {
        guard distance < 200  else { return }
        guard spinnerModel.currentPage < spinnerModel.lastPage else { return }
        spinnerModel.currentPage += 1
        fetchMoreRequest()
    }
    
    func setSpinner(currentPage: Int, lastPage: Int){
        self.spinnerModel.currentPage = currentPage
        self.spinnerModel.lastPage = lastPage
    }
    
    
    //MARK: - To bind data from model to view <ViewModel>
    func bindViewModelItemsUsing(_ model: T){ }
    
    //MARK: - DidSuccses to fetch data
    private func didSuccessFetchData(){
        network.$data
            .compactMap { $0 } // to remove nil value & first lunsh when data is Empty
            .removeDuplicates()
            .sink { [weak self] data in
                guard let self = self else { return }
                self.json.implement(type: T.self, data: data){
                    self.bindViewModelItemsUsing($0)
                    self.isInitalBinding = false
                }
            }.store(in: &subscription) // Store subscripton to cancelled when dienit calling
    }
    
    //MARK: - BindItems
    func appendItems(cells: [ADBindable]){
        switch spinnerModel.isLoadMoreEnable {
        case true:
            self.items.append(contentsOf: cells)
        case false:
            self.items = cells
        }
    }
    
    func insert(cell: ADBindable, at: Int){
        guard self.items.contains(cell) == false else { return }
        self.items.insert(cell, at: at)
    }
    
}

