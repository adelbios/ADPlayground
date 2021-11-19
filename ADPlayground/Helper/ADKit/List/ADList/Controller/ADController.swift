//
//  ADController.swift
//  Shour
//
//  Created by Adel Radwan on 27/09/2021.
//

import UIKit
import Combine
import SkeletonView

//MARK: - Typealias
private typealias dataSource = UITableViewDiffableDataSource<Int, ADBindable>

private typealias Spinner = ADCell<SpinnerCell, SpinnerModel>

class ADController<U: Any, Z: ADViewModel<U>>: UIViewController, UITableViewDelegate {
    
    //MARK: - Varables
    private var diffableDataSource: dataSource?
    
    private weak var delegate: ADControllerDelegate?
    
    let viewModel = Z()
    
    var appModel = ADSettingsModel()
    
    var actionsProxy = ADActionProxy()
    
    //MARK: - Combine variables
    var subscription = Set<AnyCancellable>()
    
    @Published var cellListModel = [CellListModel]()
    
    //MARK: - Loading, Empty, network View
     let loadingView = ADLoadingView()
    
    let emptyView = EmptyView(direction: .vertical(.middle))
    
    let networkErrorViwe = NetworkErrorView(direction: .vertical(.middle))
    
    //MARK: - tableView

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = AppColor.clear.value
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Life cycle
    @objc dynamic func settings(){ }
    @objc dynamic func setupUIComponents(){ }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.network.ObservationReachability()
        setupUIComponents()
        adSettings()
        setupUI()
        registerCells()
        bindDataSource()
        updateCollectionView()
        requestLoadingNotification()
        observeNoInternetConnection()
        settings()
        setupCustomCellEvent()
    }
    
    //MARK: - CollectionView protocol
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.didDeSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectItem(at: indexPath)
    }
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        guard viewModel.spinnerModel.currentPage != viewModel.spinnerModel.lastPage else { return }
        viewModel.loadMoreData(distance)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    //MARK: - implement pull to refresh
    func pullToRefresh(){
        self.tableView.pullToRefreh { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.reloadRequest() }
        }
    }
    
    //MARK: - Reload request
    func reloadRequest(){
        self.viewModel.makeHTTPRequest()
    }
    
    //MARK: - setupCustomCellEvent
    private func setupCustomCellEvent(){
        NotificationCenter.default.publisher(for: ADCellsAction.notificationName, object: nil)
            .sink { [weak self] not in
                guard let self = self else { return }
                guard let eventData = not.userInfo!["data"] as? ADCellActionModel,
                let cell = eventData.cell as? UITableViewCell,
                let indexPath = self.tableView.indexPath(for: cell),
                let model = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
                self.actionsProxy.invoke(action: eventData.action, cell: cell, configurator: model)
            }.store(in: &subscription)
    }
    
    //MARK: - deinit
    deinit{
        viewModel.network.terminateReachabilityObservation()
    }
    
}

//MARK: - Settings
private extension ADController {
    
    func adSettings(){
        delegate = self as? ADControllerDelegate
        loadingView.isUserInteractionEnabled = false
        view.backgroundColor = AppColor.white.value
    }
    
    func setupUI(){
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func registerCells(){
        $cellListModel
            .sink { [weak self] model in
                guard let self = self else { return }
                model.forEach {
                    self.loadingViewConfigure(with: $0)
                    self.tableView.register($0.cell, fromNib: $0.fromNib)
                }
                self.tableView.register(SpinnerCell.self)
            }.store(in: &subscription) // Store subscripton to cancelled when dienit calling
    }
    
    func loadingViewConfigure(with model: CellListModel) {
        guard let skeletonModel = model.skeletonModel else { return }
        let skModel = ADLoadingModel(count: skeletonModel.count, height: skeletonModel.height, cell: model.cell)
        var settingsModel = ADSettingsModel()
        settingsModel = self.appModel
        let left = self.appModel.layoutSectionInset.left
        let right = self.appModel.layoutSectionInset.left
        let space = self.appModel.minimumLineSpacing / 2
        settingsModel.layoutSectionInset = .init(top: space, left: left, bottom: space, right: right)
        self.loadingView.configure(with: skModel, fromNib: model.fromNib, settingsModel: settingsModel)
    }
    
}

//MARK: - Update collection View when data is come
private extension ADController {
    
    func updateCollectionView(){
        viewModel.$items
            .dropFirst() // For ignore first emitting (First lunshing)
            .removeDuplicates()
            .sink { [weak self] model in
                guard let self = self else { return }
                self.applyDataSource(items: model)
            } // did puplisher emit value
            .store(in: &subscription)  // Store subscripton to cancelled when dienit calling
    }
    
}

//MARK: - extension for request loading status it's only has 2 status <loading || finished>
private extension ADController {
    
    func requestLoadingNotification(){
        viewModel.network.$requestStatus
            .dropFirst()
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .loading:
                    self.didRequestStarting()
                case .finished:
                    self.didRequstCompleted()
                }
            }.store(in: &subscription)
    }
    
    //When ordering an api's
    func didRequestStarting(){
        guard viewModel.items.isEmpty else { return }
        self.tableView.backgroundView = nil
        self.loadingView.startLoading()
    }
    
    //When api's completed successfully
    func didRequstCompleted(){
        self.loadingView.stopLoading(isStaticList: viewModel.isStaticList)
        self.tableView.termnatePullToRefresh()
    }
    
     func observeNoInternetConnection(){
        viewModel.network.$networkErrorModel
             .compactMap{ $0 }
             .sink { [weak self] mod in
            guard let self = self else { return }
                 self.tableView.termnatePullToRefresh()
                 self.loadingView.stopLoading(isStaticList: self.viewModel.isStaticList)
                 switch self.tableView.backgroundView == nil && self.viewModel.items.isEmpty {
                 case true:
                     self.tableView.backgroundView = self.networkErrorViwe
                 case false:
                     self.viewModel.network.showNoInternetConnectionAlert(with: mod.msg)
                 }
        }.store(in: &subscription)
         
         networkErrorViwe.$isActionButtonClicked
             .dropFirst()
             .filter{ $0 == true }
             .sink { [weak self] _ in
                 guard let self = self else { return }
                 self.reloadRequest()
             }.store(in: &subscription)
    }
    
    func observeEmptyData(){
       viewModel.network.$networkErrorModel.sink { [weak self] mod in
           guard let self = self else { return }
           self.tableView.backgroundView = self.networkErrorViwe
       }.store(in: &subscription)
   }
    
}

//MARK: - Diffable
private extension ADController {
    
    func bindDataSource(){
        diffableDataSource = dataSource(tableView: tableView){ tableView, indexPath, model -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: type(of: model).cellId, for: indexPath)
            model.configure(cell: cell)
            return cell
        }
    }
    
    func applyDataSource(items: [ADBindable]) {
        setView(using: items.isEmpty)
        var snapshot = NSDiffableDataSourceSnapshot<Int, ADBindable>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(items, toSection: 0)
        snapshot.appendItems([Spinner(item: self.viewModel.spinnerModel)], toSection: 1)
        self.diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func setView(using empty: Bool){
        switch empty {
        case true:
            self.tableView.backgroundView = emptyView
        case false:
            self.tableView.backgroundView = nil
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDelegate
private extension ADController {
    
    
    func heightForItem(at indexPath: IndexPath)-> CGFloat {
        guard let model = diffableDataSource?.itemIdentifier(for: indexPath) else { return .zero }
        switch model is Spinner {
        case true:
            //To avoid extra height when spiner is finished
            return viewModel.spinnerModel.currentPage == viewModel.spinnerModel.lastPage ? 8 : 60
        case false:
            guard let delegate = delegate else { return UITableView.automaticDimension }
            return delegate.heightForItem(at: indexPath, model: model)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath){
        guard let model = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        self.actionsProxy.invoke(action: .didSelect, cell: cell, configurator: model)
    }
    
    func didDeSelectItem(at indexPath: IndexPath){
        guard let model = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        self.actionsProxy.invoke(action: .didDeSelect, cell: cell, configurator: model)
    }
}
