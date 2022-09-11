//
//  BaseComponent.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

open class BaseComponent: NSObject {
    
    /// Component context
    public weak var context: ComponentContext?
    
    // MARK: - Need override if need
    
    /// Whether the current component can be created
    open class func enableCreateComponent(context: ComponentContext) -> Bool {
        true
    }
    
    /// Create current component
    open class func component(for context: ComponentContext) -> BaseComponent {
        assert(false, "`BaseComponent` is an abstract class, please override this method.")
        return BaseComponent()
    }
}

// MARK: - Event Dispatcher

public extension BaseComponent {
    
    /// Observe that an action protocol has obtained its publication
    func observe<T>(action: T.Type) {
        self.context?.eventDispatcher.observe(action: action, component: self)
    }
    
    /// Publish an event from the action protocol
    func publish<T>(action: T.Type, handler: (_ component: T) -> Void) {
        let actionPublisher = context?.eventDispatcher.publisher(action: action)
        actionPublisher?.targets.allObjects.forEach({ target in
            if let compoment = target as? T {
                handler(compoment)
            }
        })
    }
    
    /// Get an action publisher
    private func publisher<T>(action: T.Type) -> ComponentEventMultiCast? {
        self.context?.eventDispatcher.publisher(action: action)
    }
}

// MARK: - DI

public extension BaseComponent {
    
    func bind<T>(service: T.Type, tagret: AnyObject) throws {
        try context?.diContainer.bind(service: service, target: tagret)
    }
    
    func resolve<T>(service: T.Type) throws -> T? {
        if let loader = context?.rootComponentManager?.loader {
            return try context?.diContainer.resolve(service: service, factory:loader) as? T
        }
        return nil
    }
}

/**
 If you need to sense these events, please implement the following protocol
 */

/// Need to be aware of the component lifecycle
//extension BaseComponent: ComponentLifeCycle {}

/// Need to be aware of the viewController lifecycle
//extension BaseComponent: HostLifeCycle {}

/// Need to be aware of the notification
//extension BaseComponent: NotificationCenterObserver{}
