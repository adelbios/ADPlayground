//
//  HomeViewModel.swift
//  ADPlayground
//
//  Created by Adel Radwan on 19/11/2021.
//

import UIKit

enum AppViewModel {
    typealias home = ADCell<HomeCell, HomeModel.Item>
}

class HomeViewModel: ADViewModel<HomeModel> {
    
    //MARK:- Fetch Data from request
    override func makeHTTPRequest() {
        super.makeHTTPRequest()
        network.request(HomeTarget.getRealEstate(page: 1))
    }
    
    //MARK: - Fetch More data <Pagination>
    override func fetchMoreRequest() {
        super.fetchMoreRequest()
        network.request(HomeTarget.getRealEstate(page: spinnerModel.currentPage))
    }
    
    //MARK: - Bind to UI
    override func bindViewModelItemsUsing(_ model: HomeModel) {
        setSpinner(currentPage: model.data.currentPage, lastPage: model.data.lastPage)
        let items = model.data.items.map { AppViewModel.home(item: $0) }
        appendItems(cells: items)
    }
    
}
