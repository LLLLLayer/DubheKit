//
//  DependencyInjectionServiceImpl.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

class DependencyInjectionServiceImpl: DependencyInjectionService {
    
    private let rwLock = ReadersWriterLock()
    
    private var servicesMap = NSMapTable<NSString, AnyObject>(keyOptions: .strongMemory, valueOptions: .weakMemory)
    
    func bind<T>(service: T.Type, target: AnyObject?) throws {
        guard target != nil && target is T else {
            throw DependencyInjectionServiceError.type
        }
        let key = NSString(string: "\(service)")
        rwLock.withWriteLock {
            servicesMap.setObject(target, forKey: key)
        }
    }
    
    func resolve<T>(service: T.Type, factory: DependencyInjectionFactory? = nil) throws -> T? {
        let key = NSString(string: "\(service)")
        // Cached
        var target: T?
        rwLock.withReadLock {
            target = servicesMap.object(forKey: key) as? T
        }
        if target != nil { return target }
        // Lazy Load
        if  let target = factory?.lazyResolve(service: service) {
            try bind(service: service, target: target as AnyObject)
        }
        return target
    }
}
