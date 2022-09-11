//
//  NotificationCenterObserver.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/9/3.
//

import Foundation

/// Component observations of Notification Center
public protocol NotificationCenterObserver {
    
    /// Observe `UIApplicationDidEnterBackground`
    func applicationDidEnterBackground(notification: Notification)
    
    /// Observe `UIApplicationWillEnterForeground`
    func applicationWillEnterForeground(notification: Notification)
    
    /// Observe `UIKeyboardWillShow`
    func keyboardWillShow(notification: Notification)
    
    /// Observe `UIKeyboardDidShow`
    func keyboardDidShow(notification: Notification)
    
    /// Observe `UIKeyboardWillHide`
    func keyboardWillHide(notification: Notification)
    
    /// Observe `UIKeyboardDidHide`
    func keyboardDidHide(notification: Notification)
    
    /// Observe `UIKeyboardWillChangeFrame`
    func keyboardWillChangeFrame(notification: Notification)
    
    /// Observe `UIKeyboardDidChangeFrame`
    func keyboardDidChangeFrame(notification: Notification)
}

/// Default implementation
public extension NotificationCenterObserver {
    func applicationDidEnterBackground(notification: Notification) {}
    func applicationWillEnterForeground(notification: Notification) {}
    func keyboardWillShow(notification: Notification) {}
    func keyboardDidShow(notification: Notification) {}
    func keyboardWillHide(notification: Notification) {}
    func keyboardDidHide(notification: Notification) {}
    func keyboardWillChangeFrame(notification: Notification) {}
    func keyboardDidChangeFrame(notification: Notification) {}
}

