//
//  ComponentEventDispatcher.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public class ComponentEventDispatcher {
    
    private let rwLock = ReadersWriterLock()
    
    private var observersMap: [String : ComponentEventMultiCast] = [:]
    
    func observe<T>(action: T.Type, component: BaseComponent) {
        guard component is T else { return }
        let key = "\(action)"
        var multiCast: ComponentEventMultiCast?
        rwLock.withReadLock {
            multiCast = observersMap[key]
            if multiCast == nil {
                multiCast = ComponentEventMultiCast()
            }
        }
        multiCast?.add(component: component)
        rwLock.withReadLock {
            observersMap[key] = multiCast
        }
    }
    
    public func publisher<T>(action: T.Type) -> ComponentEventMultiCast? {
        var publisher: ComponentEventMultiCast?
        rwLock.withReadLock {
            publisher = observersMap["\(action)"]
        }
        return publisher
    }
}
