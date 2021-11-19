//
//  VenomBasicAlertController.swift
//  VenomAlert
//
//  Created by Adel Radwan on 4/10/21.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit
import SwiftEntryKit

class AppAlert: UIView {
    
    private enum ClcikedOnType{ case leftBtn,rightBtn,dismiss }
    
    private var clickedOnType: ClcikedOnType!
    
    var didClickedOnRightBtn: (()->())?
    
    var didClickedOnLeftBtn: (()->())?
    
    var didDismiss: (()->())?
    
    private var useDismissCallBack: Bool = false
    
    public static var `appearance` = AppAlertAppearance()
    
    lazy var myAppearance: AppAlertAppearance = type(of: self).appearance { didSet{ setAppearance() } }
    
    
    //MARK: - UI Components
    private let imageView = UIImageView()
    
    private let titleTxt: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageTxt: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    private let rightBtn: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftButton, rightBtn])
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(
        frame: CGRect = .zero, image: String? = nil, title: String? = nil, msg: String, leftBtnTitle: String? = nil,
        rightBtnString: String? = nil, useDismissCallBack: Bool = false
    ) {
        super.init(frame: frame)
        self.useDismissCallBack = useDismissCallBack
        leftButton.isHidden = leftBtnTitle == nil
        rightBtn.isHidden   = rightBtnString == nil
        imageView.isHidden  = image == nil
        titleTxt.isHidden   = title == nil
        leftButton.setTitle(leftBtnTitle, for: .normal)
        rightBtn.setTitle(rightBtnString, for: .normal)
        messageTxt.text = msg
        titleTxt.text = title
        if let img = image { imageView.image = UIImage(named: img) }
        setAppearance()
        setupUI(isButtonUse: leftBtnTitle != nil && rightBtnString != nil)
        setEvents()
    }
    
    //MARK: - Show Alert
    func show(){
        let view = UIApplication.shared.windows.first?.rootViewController?.view
        view?.endEditing(true)
        SwiftEntryKit.showAppAlertForView(self){ [weak self] in
            guard let self = self else { return }
            switch self.clickedOnType {
            case .leftBtn :
                self.didClickedOnLeftBtn?()
            case .rightBtn:
                self.didClickedOnRightBtn?()
            case .dismiss :
                self.didDismiss?()
            case.none     :
                guard self.useDismissCallBack == true else { return }
                self.didDismiss?()
            }
        }
    }
    
    
    
}

//MARK: - Settings
extension AppAlert {
    
    private func setupUI(isButtonUse: Bool){
        buttonsStackView.semanticContentAttribute = .forceLeftToRight
        self.buttonsStackView.isHidden = !isButtonUse
        let stackView = UIStackView(arrangedSubviews: [imageView, titleTxt, messageTxt, buttonsStackView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.setCustomSpacing(25, after: imageView)
        stackView.setCustomSpacing(16, after: titleTxt)
        stackView.setCustomSpacing(isButtonUse ? 30 : 0, after: messageTxt)
        stackView.layoutMargins = .init(top: 30, left: 26, bottom: 30, right: 26)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //buttonsStackView
            buttonsStackView.heightAnchor.constraint(equalToConstant: 56),
            buttonsStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 92)
        ])
    }
    
    
    private func setAppearance(){
        backgroundColor = myAppearance.bgColor
        
        //ImageView
        imageView.contentMode = myAppearance.imageViewMode
        imageView.tintColor = myAppearance.imageColor.value
        imageView.clipsToBounds = true
        
        //MessageTxt
        messageTxt.textColor = myAppearance.messageColor
        messageTxt.font = myAppearance.messageFont
        
        //rightBtn
        rightBtn.backgroundColor = myAppearance.rightButtonBgColor
        rightBtn.setTitleColor(myAppearance.rightButtonColor, for: .normal)
        rightBtn.titleLabel?.font = myAppearance.rightButtonFont
        
        //leftButton
        leftButton.backgroundColor = myAppearance.leftButtonBgColor
        leftButton.setTitleColor(myAppearance.leftButtonColor, for: .normal)
        leftButton.titleLabel?.font = myAppearance.leftButtonFont
        
        //titleText
        titleTxt.textColor = myAppearance.titleColor
        titleTxt.font = myAppearance.titleFont
        
    }
    
    private func addCornerRadius(to views: [UIView]){
        views.forEach {
            $0.layer.cornerRadius = 6
            $0.layer.masksToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCornerRadius(to: [self, leftButton, rightBtn])
    }
    
}

//MARK: - Events Handler
private extension AppAlert {
    
    func setEvents(){
        leftButton.addTarget(self, action: #selector(self.didLeftButtonClicked), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(self.didRightButtonClicked), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelfClicked))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func didLeftButtonClicked(){
        self.clickedOnType = .leftBtn
        SwiftEntryKit.dismiss()
    }
    
    @objc func didRightButtonClicked(){
        self.clickedOnType = .rightBtn
        SwiftEntryKit.dismiss()
    }
    
    @objc func didSelfClicked(){
        self.clickedOnType = .dismiss
        SwiftEntryKit.dismiss()
    }
    
}
