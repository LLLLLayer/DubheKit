//
//  ComponentContext.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public class ComponentContext {
    
    weak var rootComponentManager: ComponentManager?
    
    public weak var viewController: UIViewController?
    
    public let eventDispatcher = ComponentEventDispatcher()
    
    let diContainer: DependencyInjectionService = DependencyInjectionServiceImpl()
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
