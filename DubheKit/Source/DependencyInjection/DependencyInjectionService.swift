//
//  DependencyInjectionService.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public enum DependencyInjectionServiceError: Error {
    
    /// Parameter type error
    case type
}

protocol DependencyInjectionFactory {
    
    /// Lazy Loading service
    func lazyResolve<T>(service: T.Type) -> T?
}

protocol DependencyInjectionService {
    
    /// Bind the target to the service
    func bind<T>(service: T.Type, target: AnyObject?) throws
    
    /// Get the target according to the service
    ///
    /// - Note: If it is not bound, load it through factory
    func resolve<T>(service: T.Type, factory: DependencyInjectionFactory?) throws -> T?
}
