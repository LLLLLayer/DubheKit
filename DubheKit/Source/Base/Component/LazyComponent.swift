//
//  LazyComponent.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/9/4.
//

import Foundation

public protocol LazyComponent {
    
    /// Types corresponding to lazy loaded components
    static func lazyService() -> String
}
