//
//  ComponentLoader.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

protocol ComponentLoaderDelegate {
    func didCreateLazyComponent(loader: ComponentLoader, lazyComponent: BaseComponent)
}

class ComponentLoader {
    
    let componentNames: [String]
    
    let lazycomponentNames: [String]
    
    let context: ComponentContext
    
    var delegate: ComponentLoaderDelegate?
    
    init(context: ComponentContext, componentNames: [String], lazycomponentNames: [String]) {
        self.context = context
        self.componentNames = componentNames
        self.lazycomponentNames = lazycomponentNames
    }
    
    func makeComponents() -> [BaseComponent] {
        return componentNames.compactMap { name in
            createComponent(name: name, context: context)
        }
    }
    
    func createComponent(name: String, context: ComponentContext) -> BaseComponent? {
        let `class`: AnyClass? = NSClassFromString(name)
        guard let `class` = `class`,
              let componentClass = (`class` as? BaseComponent.Type),
              componentClass.enableCreateComponent(context: context) else {
            return nil
        }
        if let lifeCycle = componentClass as? ComponentLifeCycle.Type {
            lifeCycle.willMounted(context: context)
        }
        let component = componentClass.component(for: context)
        component.context = context
        if let lifeCycle = component as? ComponentLifeCycle {
            lifeCycle.didMounted(context: context)
        }
        return component
    }
}

extension ComponentLoader: DependencyInjectionFactory {
    
    func lazyResolve<T>(service: T.Type) -> T? {
        let (loader, name) = findLoader(for: service)
        guard let loader = loader, let name = name else {
            return nil
        }
        let componment = loader.createComponent(name: name, context: context)
        guard let service = componment as? T else {
            return nil
        }
        loader.delegate?.didCreateLazyComponent(loader: loader, lazyComponent: componment!)
        return service
    }
    
    
    func findLoader<T>(for service: T.Type) -> (ComponentLoader?, String?) {
        var componmentName: String?
        if lazycomponentNames.contains(where: { name in
            let `class`: AnyClass? = NSClassFromString(name)
            guard let `class` = `class`,
                  let componentClass = `class` as? LazyComponent.Type,
                  String(reflecting: service) == componentClass.lazyService() else {
                return false
            }
            componmentName = name
            return true
        }) {
            return (self, componmentName)
        }
        
        guard let manager = self.delegate as? ComponentManager else {
            return (nil, componmentName)
        }
        if let subManagers = manager.subManager {
            for subManager in subManagers {
                let (loader, name) = subManager.loader.findLoader(for: service)
                if let loader = loader, let name = name {
                    return (loader, name)
                }
            }
        }
        return (nil, componmentName)
    }
}
