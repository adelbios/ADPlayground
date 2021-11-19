//
//  HomeController.swift
//  ADPlayground
//
//  Created by Adel Radwan on 19/11/2021.
//

import UIKit

class HomeController: ADController<HomeModel, HomeViewModel> {
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.makeHTTPRequest()
        pullToRefresh()
        handleCellAction()
        emptyView.change(position: .horizontal(.top))
        emptyView.useActionButton = false
        self.navigationItem.title = L10n.Home.navTitle
    }
    
}

//MARK: - settings
extension HomeController {
    
    override func settings() {
        cellListModel = [CellListModel(HomeCell.self, skeletonModel: .init(count: 4, height: 138))]
    }
    
    override func setupUIComponents() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

extension HomeController: ADControllerDelegate {
    
    func heightForItem(at: IndexPath, model: ADBindable) -> CGFloat {
        return 138
    }
    
}


//MARK: - Events
private extension HomeController {
    
    func handleCellAction(){
        actionsProxy.on(.didSelect) { (model: AppViewModel.home) in
            
            DispatchQueue.main.async {
                self.push(to: UIViewController())
            }
        }
        
    }
}
