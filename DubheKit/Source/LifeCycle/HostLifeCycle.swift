//
//  HostLifeCycle.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

/// The life cycle of the viewController to which it belongs
public protocol HostLifeCycle {
    
    /// The own viewController triggers the `viewDidLoad` method
    func hostViewDidLoad()
    
    /// The own viewController triggers the `viewWillAppear` method
    func hostViewWillAppear()
    
    /// The own viewController triggers the `viewDidAppear` method
    func hostViewDidAppear()
    
    /// The own viewController triggers the `viewWillDisappear` method
    func hostViewWillDisappear()
    
    /// The own viewController triggers the `ViewDidDisappear` method
    func hostViewDidDisappear()
}

/// Default implementation
public extension HostLifeCycle {
    func hostViewDidLoad() {}
    func hostViewWillAppear() {}
    func hostViewDidAppear() {}
    func hostViewWillDisappear() {}
    func hostViewDidDisappear() {}
}
