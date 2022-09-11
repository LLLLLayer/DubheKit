//
//  TipsComponent.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import DubheKit

class TipsComponent: BaseComponent {
    
    var componentManager: ComponentManager?
    
    // MARK: - override
    
    override class func enableCreateComponent(context: ComponentContext) -> Bool {
        true
    }
    
    override class func component(for context: ComponentContext) -> BaseComponent {
        TipsComponent()
    }
}

// MARK: - TipsComponentInterface

extension TipsComponent: TipsComponentInterface {
    
    func checkAndShowtips(message: Message) {
        if Bool.random() {
            checkAndCreateComponentManager()
            guard let subComponent = componentManager?.components?.randomElement(),
                  let subComponentService = subComponent as? TipsSubComponentInterface else {
                return
            }
            let tips = subComponentService.message()
            let alert = UIAlertController(title: "You get tips！", message: tips, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            context?.viewController?.present(alert, animated: true)
        }
    }
    
    private func checkAndCreateComponentManager () {
        if componentManager == nil {
            componentManager = createComponentManager()
            componentManager?.resolveComponents()
        }
    }
}

// MARK: - ComponentContainer

extension TipsComponent: ComponentContainer {
    
    open func createComponentManager() -> ComponentManager {
        ComponentManager(dependency: self)
    }
}

// MARK: - ComponentManagerDependency

extension TipsComponent: ComponentManagerDependency {
    
    func componentNames(context: ComponentContext) -> [String] {
        [
            "DubheKit_Example.LuckTipsComponent",
            "DubheKit_Example.SafeTipsComponent",
        ]
    }
    
    func componentContext() -> ComponentContext {
        context ?? ComponentContext(viewController: (context?.viewController)!)
    }
}

// MARK: - LazyComponent

extension TipsComponent: LazyComponent {
    
    static func lazyService() -> String {
        String(reflecting: TipsComponentInterface.self)
    }
}
