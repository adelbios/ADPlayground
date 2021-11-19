//
//  ADLoadingView.swift
//  Shour
//
//  Created by Adel Radwan on 06/11/2021.
//

import UIKit
import SkeletonView

class ADLoadingView: BaseView {
    
    //MARK: - Variables
    private var settingsModel = ADSettingsModel()
    
    private var model = [ADLoadingModel]()
    
    //MARK: - UI Components
     lazy var tableView: UITableView = {
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.white.value
        tableView.isUserInteractionEnabled = false
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.isSkeletonable = true
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.separatorInset.left = UIScreen.main.bounds.width
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func setupViews() {
        setupUI()
        viewSettings()
    }
    
    //MARK: - Skeleton
    func startLoading(){
        self.tableView.alpha = 1
        self.tableView.startSkeleton()
    }
    
    func stopLoading(isStaticList: Bool){
        guard isStaticList == false else {
            self.tableView.alpha = 0
            self.tableView.stopSkeleton()
            return
        }
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { [weak self] in
            guard let self = self else { return }
            self.tableView.alpha = 0
        }
        
        animator.startAnimation()
        animator.addCompletion { [weak self] position in
            guard let self = self else { return }
            guard position == .end else { return }
            self.tableView.stopSkeleton()
        }
        
        
    }
    
    //MARK: - Configure
    func configure(with model: ADLoadingModel, fromNib: Bool, settingsModel: ADSettingsModel){
        self.model.append(model)
        self.settingsModel = settingsModel
        self.tableView.register(model.cell!, fromNib: fromNib)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

//MARK: -  Setup UI
private extension ADLoadingView {
    
    func viewSettings(){
        backgroundColor = AppColor.clear.value
    }
    
    func setupUI(){
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension ADLoadingView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

//MARK: - UITableViewDelegate
extension ADLoadingView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.model[indexPath.section].height
    }
    
}

//MARK: - SkeletonCollectionViewDataSource
extension ADLoadingView: SkeletonTableViewDataSource {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return self.model.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model[section].count
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let cell = model[indexPath.section].cell else { return "" }
        return "\(cell)"
    }
    
}
