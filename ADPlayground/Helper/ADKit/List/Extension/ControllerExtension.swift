//
//  Controller.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit
import SafariServices
import SwiftUI
import MessageUI

//MARK: - Main Extension
extension UIViewController {
    
    func push(to: UIViewController){
        navigationController?.pushViewController(to, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func pop(_ completion: @escaping ()->() = {}) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popViewController(animated: true)
        CATransaction.commit()
    }
    
    func close(_ completion: @escaping ()->() = {}){
        dismiss(animated: true, completion: completion)
    }
    
    func setNavigationBar(hidden: Bool = true, animation: Bool){
        navigationController?.setNavigationBarHidden(hidden, animated: animation)
    }
    
}



//MARK: - SwiftUI
extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}

extension UIView {
    
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            //
        }
    }
    
    
    func showPreview() -> some View {
        // inject self (the current UIView) for the preview
        Preview(view: self)
    }
}

