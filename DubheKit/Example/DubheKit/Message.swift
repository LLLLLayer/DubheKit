//
//  Message.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct Message: Hashable {
    
    let uuid = UUID().uuidString
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
}
