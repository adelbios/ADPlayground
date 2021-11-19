//
//  EmptyView.swift
//  Que
//
//  Created by Adel Radwan on 7/23/20.
//  Copyright © 2020 Adel Radwan. All rights reserved.
//

import UIKit
import Lottie



class EmptyView: UIView {
    
    enum Direction: Equatable {
        enum Position { case top, middle, bottom }
        case vertical(Position)
        case horizontal(Position)
    }
    
    private var direction: Direction = .vertical(.middle)
        
    @Published private(set) var isActionButtonClicked: Bool = false
    
    var image: String? {
        didSet{
            guard let image = image else { return }
            self.animationView.isHidden = true
            self.imageView.image = UIImage(named: image)
        }
    }
    
    var title: String = L10n.EmptyData.title {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    var message: String = L10n.EmptyData.msg {
        didSet{
            self.messageLabel.text = message
        }
    }
    
    var actionTitle: String = "Action" {
        didSet{
            actionButton.setTitle(actionTitle, for: .normal)
        }
    }
    
    lazy var style = EmptyViewAppearance(){
        didSet{
            setStyle()
        }
    }
    
    var useActionButton: Bool = false {
        didSet{
            self.actionButton.isHidden = !useActionButton
        }
    }
    
    //MARK: - UI Components
    private var holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var animationView: AnimationView = {
        let v = AnimationView()
        v.backgroundBehavior = .pauseAndRestore
        v.loopMode = .autoReverse
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.backgroundColor = AppColor.clear.value
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private lazy var imageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //Vertical -> Top, Middle, Bottom
    private lazy var fullSizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [animationView, imageView, titleLabel, messageLabel, actionButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment    = .fill
        stackView.distribution = .fill
        stackView.spacing      = 12
        stackView.setCustomSpacing(30, after: messageLabel)
        return stackView
    }()
    
    //horizontal-> Top, Middle, Bottom
    private lazy var samllSizeStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.layoutMargins.top = 16
        vStack.isLayoutMarginsRelativeArrangement = true
        let stackView = UIStackView(arrangedSubviews: [animationView, imageView, vStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(frame: CGRect = .zero, direction: Direction = .vertical(.middle)) {
        super.init(frame: frame)
        useActionButton = false
        self.direction = direction
        playAnimation()
        settings()
        setupHolderView()
        selectLayoutUsingDirection()
        setStyle()
    }
    
    func setStyle(){
        holderView.backgroundColor = style.color.holderView
        self.titleLabel.textColor = style.color.title
        self.messageLabel.textColor   = style.color.message
        
        //actionButton
        actionButton.backgroundColor  = style.color.actionBackground
        actionButton.titleLabel?.font = style.font.actionFont
        actionButton.setTitleColor(style.color.actionTitle, for: .normal)
        
        switch self.direction {
        case .horizontal:
            self.titleLabel.font = style.font.smallTitle
            self.messageLabel.font = style.font.smallMessage
            self.titleLabel.textAlignment = style.alignment.small
            self.messageLabel.textAlignment = style.alignment.small
        case .vertical:
            self.titleLabel.font = style.font.title
            self.messageLabel.font = style.font.message
            self.titleLabel.textAlignment = style.alignment.full
            self.messageLabel.textAlignment = style.alignment.full
        }
    }
    
    func set(text: String, span: String) {
        let string = NSMutableAttributedString(string: "\(text) \(span)")
        string.setColor(color: AppColor.darkGray.value, forText: span)
        messageLabel.attributedText = string
    }
    
    func change(position to: Direction){
        self.direction = to
        setStyle()
        setupHolderView()
        selectLayoutUsingDirection()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.holderView.setNeedsUpdateConstraints()
        }
    }
    
}


//MARK: - Settings
extension EmptyView {
    
    private func settings(){
        self.imageView.isHidden = true
        backgroundColor = AppColor.white.value
    }
    
    @objc private func actionButtonClicked(){
        self.isActionButtonClicked = true
    }
    
    func playAnimation(){
        let animation = Animation.named("EmptyData")
        self.animationView.animation = animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.animationView.play()
        }
    }
    
    private func setupHolderView(){
        holderView.removeFromSuperview()
        addSubview(holderView)
        NSLayoutConstraint.activate([
            self.holderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.holderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.holderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            setLayoutForPosition()
        ])
    }
    
    private func setLayoutForPosition()-> NSLayoutConstraint {
        switch direction {
        case .vertical(.top), .horizontal(.top):
            return holderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        case .vertical(.middle), .horizontal(.middle):
            return holderView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        case .vertical(.bottom):
            return holderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        case .horizontal(.bottom):
            return holderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: useActionButton == true ? -80 : -12)
        }
    }
    
    private func selectLayoutUsingDirection(){
        switch self.direction {
        case .vertical:
            setupVerticalLayoutDirection()
        case .horizontal:
            setupHorizontalLayoutDirection()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.layer.cornerRadius  = 12
        actionButton.layer.masksToBounds = true
    }
    
}

//MARK: - UI For vertical direction
private extension EmptyView {
    
    func setupVerticalLayoutDirection(){
        holderView.addSubview(fullSizeStackView)
        NSLayoutConstraint.activate([
            //fullSizeStackView
            fullSizeStackView.topAnchor.constraint(equalTo: holderView.topAnchor),
            fullSizeStackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 30),
            fullSizeStackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -30),
            fullSizeStackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
            //lottieView
            animationView.widthAnchor.constraint(equalToConstant: 150),
            animationView.heightAnchor.constraint(equalToConstant: 150),
            //emptyImageView
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            //actionButton
            actionButton.heightAnchor.constraint(equalToConstant: 45),
            actionButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
        ])
    }
    
}



//MARK: - UI For horizontal direction
private extension EmptyView {
    
    func setupHorizontalLayoutDirection(){
        holderView.addSubview(samllSizeStackView)
        addSubview(actionButton)
        NSLayoutConstraint.activate([
            //fullSizeStackView
            samllSizeStackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8),
            samllSizeStackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            samllSizeStackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -45),
            samllSizeStackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
            //animationView
            animationView.widthAnchor.constraint(equalToConstant: 120),
            animationView.heightAnchor.constraint(equalToConstant: 120),
            //emptyImageView
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            //actionButton
            actionButton.topAnchor.constraint(equalTo: samllSizeStackView.bottomAnchor, constant: 12),
            actionButton.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 30),
            actionButton.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -30),
            actionButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
}

