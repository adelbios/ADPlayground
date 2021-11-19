//
//  KeyboardNotification+.swift
//  Roseyar
//
//  Created by Adel Radwan on 4/30/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit

//MARK: - notificationCenter
extension UIViewController {
    
    func addKeyboardObservationFor(_ scrollView: UIScrollView, usingBlock WillShowBlock: ((CGSize?) -> Void)? = nil, WillHideBlock: ((CGSize?) -> Void)? = nil){
        self.registerForKeyboardWillShowNotification(scrollView, usingBlock: WillShowBlock)
        self.registerForKeyboardWillHideNotification(scrollView, usingBlock: WillHideBlock)
    }
    
    func terminateKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
    
    private func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
    
}


extension UIScrollView {
    
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
    
    
    func handleKeyboardFor(_ textView: UITextView){
        let scrollPoint : CGPoint = CGPoint.init(x:0, y:textView.frame.size.height + 20)
        self.setContentOffset(scrollPoint, animated: true)
    }
    
    func removeHandleTextViewKeyboard(){
        self.setContentOffset(CGPoint.zero, animated: true)
    }
    
}


