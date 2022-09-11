//
//  ComponentManager.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public class ComponentManager: NSObject {
    
    /// Is it the root Component
    var isRoot: Bool = false
    
    /// Context between components
    let context: ComponentContext
    
    /// Component loader
    let loader: ComponentLoader
    
    /// The initialized components
    public var components: [BaseComponent]? {
        didSet {
            containerComponents = components?.compactMap { component in
                return component as? BaseComponent & ComponentContainer
            }
        }
    }
    
    /// List of components that have child components
    var containerComponents: [BaseComponent & ComponentContainer]? {
        didSet {
            subManager = containerComponents?.compactMap { containerComponent in
                containerComponent.componentManager
            }
        }
    }
    
    /// ComponentManager of child component
    var subManager: [ComponentManager]?
    
    /// Initialization method
    public init(dependency: ComponentManagerDependency) {
        context = dependency.componentContext()
        let components = dependency.componentNames(context: context)
        let laztComponents = dependency.lazyComponentNames(context: context)
        loader = ComponentLoader(context: context, componentNames: components, lazycomponentNames: laztComponents)
        super.init()
        context.rootComponentManager = self
        loader.delegate = self
    }
    
    /// Construct all components
    public func resolveComponents() {
        self.components = loader.makeComponents()
        if isRoot {
            forEachCompoment(as: ComponentLifeCycle.self) { $0.didAllMounted(context:context) }
        }
    }
}

// MARK: - ComponentLoaderDelegate

extension ComponentManager: ComponentLoaderDelegate {
    
    func didCreateLazyComponent(loader: ComponentLoader, lazyComponent: BaseComponent) {
        components?.append(lazyComponent)
    }
}

// MARK: - HostLifeCycle

extension ComponentManager: HostLifeCycle {
    
    public func hostViewDidLoad() {
        forEachCompoment(as: HostLifeCycle.self) { $0.hostViewDidLoad() }
    }
    
    public func hostViewWillAppear() {
        forEachCompoment(as: HostLifeCycle.self) { $0.hostViewWillAppear() }
    }
    
    public func hostViewDidAppear() {
        forEachCompoment(as: HostLifeCycle.self) { $0.hostViewDidAppear() }
    }
    
    public func hostViewWillDisappear() {
        forEachCompoment(as: HostLifeCycle.self) { $0.hostViewWillDisappear() }
    }
    
    public func hostViewDidDisappear() {
        forEachCompoment(as: HostLifeCycle.self) { $0.hostViewDidDisappear() }
    }
}

// MARK: - NotificationCenterObserver

extension ComponentManager: NotificationCenterObserver {
    
    public func applicationDidEnterBackground(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.applicationDidEnterBackground(notification: notification)
        }
    }
    
    public func applicationWillEnterForeground(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.applicationWillEnterForeground(notification: notification)
        }
    }
    
    public func keyboardWillShow(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardWillShow(notification: notification)
        }
    }
    
    public func keyboardDidShow(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardDidShow(notification: notification)
        }
    }
    
    public func keyboardWillHide(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardWillHide(notification: notification)
        }
    }
    
    public func keyboardDidHide(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardDidHide(notification: notification)
        }
    }
    
    public func keyboardWillChangeFrame(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardWillChangeFrame(notification: notification)
        }
    }
    
    public func keyboardDidChangeFrame(notification: Notification) {
        forEachCompoment(as: NotificationCenterObserver.self) {
            $0.keyboardDidChangeFrame(notification: notification)
        }
    }
}

// MARK: - Tools

private extension ComponentManager {
    
    func forEachCompoment<T>(as: T.Type, handler: (T) -> Void) {
        components?.forEach {
            if let compoment = $0 as? T {
                handler(compoment)
            }
        }
    }
}
