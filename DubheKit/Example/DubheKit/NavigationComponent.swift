//
//  NavigationComponent.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/8/31.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import DubheKit

class NavigationComponent: BaseComponent {
    
    // MARK: - Property
    
    private let navigationView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: UIScreen.main.bounds.width,
            height: 100.0))
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(
            x: 0.0,
            y: 40.0,
            width: UIScreen.main.bounds.width,
            height: 60.0))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        return label
    }()
    
    // MARK: - Override
    
    override class func enableCreateComponent(context: ComponentContext) -> Bool {
        print("Check enable create NavigationComponent")
        return true
    }
    
    override class func component(for context: ComponentContext) -> BaseComponent {
        print("Create NavigationComponent")
        return NavigationComponent()
    }
}

// MARK: - InputComponentAction

extension NavigationComponent: InputComponentAction {
    
    func update(state: InputState) {
        switch state {
        case .normal:
            titleLabel.text = "You are not typing."
        case .input:
            titleLabel.text = "You are typing..."
        }
    }
}

// MARK: - ComponentLifeCycle

extension NavigationComponent: ComponentLifeCycle {
    
    static func willMounted(context: ComponentContext) {
        print("NavigationComponent reveived `willMounted`")
    }
    
    func didMounted(context: ComponentContext) {
        print("NavigationComponent reveived `didMounted`")
    }
    
    func didAllMounted(context: ComponentContext) {
        print("NavigationComponent reveived `didAllMounted`")
        
        // Observer
        observe(action: InputComponentAction.self)
    }
}

// MARK: - HostLifeCycle

extension NavigationComponent: HostLifeCycle {
    
    func hostViewDidLoad() {
        print("NavigationComponent reveived `hostViewDidLoad`")
        
        // Add NavigationView
        context?.viewController?.view.addSubview(navigationView)
        navigationView.addSubview(titleLabel)
        update(state: InputState.normal)
    }
    
    func hostViewWillAppear() {
        print("NavigationComponent reveived `hostViewDidLoad`")
    }
    
    func hostViewDidAppear() {
        print("NavigationComponent reveived `hostViewDidLoad`")
    }
    
    func hostViewWillDisappear() {
        print("NavigationComponent reveived `hostViewDidLoad`")
    }
    
    func hostViewDidDisappear() {
        print("NavigationComponent reveived `hostViewDidLoad`")
    }
}
