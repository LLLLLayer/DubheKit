//
//  ComponentLifeCycle.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

/// Lifecycle of the current component
public protocol ComponentLifeCycle {
    
    /// Component is about to be instantiated
    static func willMounted(context: ComponentContext)
    
    /// Component initialization is complete
    func didMounted(context: ComponentContext)
    
    /// All components are initialized
    func didAllMounted(context: ComponentContext)
}

/// Default implementation
public extension ComponentLifeCycle {
    static func willMounted(context: ComponentContext) {}
    func didMounted(context: ComponentContext) {}
    func didAllMounted(context: ComponentContext) {}
}
