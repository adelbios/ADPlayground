//
//  HomeCell.swift
//  ADPlayground
//
//  Created by Adel Radwan on 19/11/2021.
//

import UIKit
import SkeletonView

class HomeCell: BaseTableCell {
    
    private let realEstateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Fonts.cairo.bold.font(size: 16)
        label.textColor = AppColor.blue.value
        label.text = "jkdhkjdfhdkfj"
        return label
    }()
    
    private let descLabel: UILabel = {
       let label = UILabel()
        label.font = Fonts.cairo.regular.font(size: 12)
        label.textColor = AppColor.blue.value(alpha: 0.7)
        label.text = "jkdhkjdfhdkfj"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [SpaceView(space: 8), titleLabel, descLabel, UIView()])
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .fill
        vStack.spacing = 7
        vStack.isSkeletonable = true
        let mainStack = UIStackView(arrangedSubviews: [realEstateImageView, vStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 18
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
   
    //MARK: - LifeCycle
    override func setupViews() {
        setupUI()
        cellSettings()
        enableSkeletone()
    }
    
}
//MARK: -  ConfigCell
extension HomeCell: ADCellConfigDelegate {
    
    func configure(data: HomeModel.Item) {
        titleLabel.text = data.realEstateTitle
        descLabel.text  = data.description
        realEstateImageView.loadImageWith(data.firstImg)
    }
}

//MARK: -  Setup UI
extension HomeCell {
    
    private func setupUI(){
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            //realEstateImageView
            realEstateImageView.widthAnchor.constraint(equalToConstant: 86),
        ])
        addBorder(with: .bottom, color: AppColor.lightGray.value, thickness: 0.5)
        
    }
    
    private func cellSettings(){
        backgroundColor = AppColor.white.value
    }
    
    private func enableSkeletone(){
        enableSkeletoneFor([self, stackView, realEstateImageView, titleLabel, descLabel])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        realEstateImageView.layer.cornerRadius = 8
        realEstateImageView.layer.masksToBounds = true
    }
}

class SpaceView: UIView {
    
    var space: CGFloat = 0
    
    init(frame: CGRect = .zero, space: CGFloat) {
        super.init(frame: frame)
        self.space = space
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return .init(width: UIScreen.main.bounds.width, height: space)
    }
    
}
