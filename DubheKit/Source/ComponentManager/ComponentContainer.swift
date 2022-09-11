//
//  ComponentContainer.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public protocol ComponentContainer {
    
    /// Component manager
    var componentManager: ComponentManager? { get }
}
