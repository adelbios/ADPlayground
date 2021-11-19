//
//  NetworkErrorStepsView.swift
//  KnzTupe
//
//  Created by Adel Radwan on 7/8/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit

class NetworkErrorStepsView: UIView {
    
    var message: String  = "" {
        didSet{
            titleLabel.text = message
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        imageView.tintColor = AppColor.blue.value
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "تحقق من المودم و الراوتر"
        label.font = Fonts.cairo.regular.font(size: 14)
        label.textColor = AppColor.blue.value
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            //stackView
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //iconImageView
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
}


