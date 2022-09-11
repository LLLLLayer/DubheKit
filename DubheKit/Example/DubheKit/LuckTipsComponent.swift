//
//  LuckTipsComponent.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import DubheKit

class LuckTipsComponent: BaseComponent {
    
    override class func enableCreateComponent(context: ComponentContext) -> Bool {
        true
    }
    
    override class func component(for context: ComponentContext) -> BaseComponent {
        LuckTipsComponent()
    }
}

extension LuckTipsComponent: LuckComponentInterface {
    func message() -> String {
        "You are lucky!"
    }
}
