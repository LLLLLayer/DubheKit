//
//  InputComponentAction.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/1.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import DubheKit

enum InputState: Int {
    case normal
    case input
}

protocol InputComponentAction {
    
    /// Input state changed
    func update(state: InputState)
    
    /// rigin.y  will change
    func originYWillChange(newValue: CGFloat, duration: TimeInterval)
}

/// Default implementation
extension InputComponentAction {
    func update(state: InputState) {}
    func originYWillChange(newValue: CGFloat, duration: TimeInterval) {}
}
