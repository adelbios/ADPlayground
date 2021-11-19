//
//  SpinnerCell.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import UIKit

class SpinnerCell: BaseTableCell {

    lazy var spinnerView: SpinnerView = {
        let view = SpinnerView()
        self.contentView.addSubview(view)
        return view
    }()
    
    //MARK: - LifeCycle
    override func setupViews() {
        cellSettings()
    }
    
}
//MARK: -  ConfigCell
extension SpinnerCell: ADCellConfigDelegate {
    
    func configure(data: SpinnerModel) {
        spinnerView.configure(data: data)
    }
}

//MARK: -  Setup UI
extension SpinnerCell {
    
    private func cellSettings(){
        backgroundColor = AppColor.clear.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        spinnerView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
