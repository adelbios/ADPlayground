//
//  SpinnerView.swift
//  Shour
//
//  Created by Adel Radwan on 10/11/2021.
//

import UIKit

class SpinnerView: BaseView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        self.addSubview(view)
        return view
    }()
   
    //MARK: - LifeCycle
    override func setupViews() {
        viewSettings()
    }
    
    func configure(data: SpinnerModel) {
        switch data.currentPage == data.lastPage {
        case true:
            activityIndicator.stopAnimating()
        case false:
            activityIndicator.startAnimating()
        }
    }
    
}
//MARK: -  Setup UI
extension SpinnerView {
    
    private func viewSettings(){
        backgroundColor = AppColor.clear.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
