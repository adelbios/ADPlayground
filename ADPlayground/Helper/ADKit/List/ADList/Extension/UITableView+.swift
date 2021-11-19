//
//  UITableView+.swift
//  Shour
//
//  Created by Adel Radwan on 09/11/2021.
//

import UIKit
import CRRefresh
import SkeletonView

internal extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type, fromNib: Bool = false){
        switch fromNib {
        case true:
            self.register(UINib(nibName: "\(cell)", bundle: Bundle.main), forCellReuseIdentifier: "\(cell)")
        case false:
            self.register(cell, forCellReuseIdentifier: "\(cell)")
        }
    }
    
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath)->T {
        return self.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T
    }
    
    //Skeleton
    func startSkeleton(){
        self.showAnimatedGradientSkeleton(transition: .none)
    }
    
    func stopSkeleton(){
        self.hideSkeleton(reloadDataAfter: true, transition: .none)
    }
    
    //MARK: - Pull to refresh
    func pullToRefreh(_ completion: @escaping ()-> Void){
        let headerView = FastAnimator()
        self.cr.addHeadRefresh(animator: headerView) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            completion()
        }
    }
    
    func termnatePullToRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.cr.endHeaderRefresh()
        }
    }
    
}
