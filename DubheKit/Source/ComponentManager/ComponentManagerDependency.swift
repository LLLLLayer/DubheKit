//
//  ComponentManagerDependency.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public protocol ComponentManagerDependency {
    
    /// Component Context
    func componentContext() -> ComponentContext
    
    /// Component names
    func componentNames(context: ComponentContext) -> [String]
    
    /// Lazy component names
    func lazyComponentNames(context: ComponentContext) -> [String]
}

/// Default implementation
public extension ComponentManagerDependency {
    func lazyComponentNames(context: ComponentContext) -> [String] {
        return []
    }
}
