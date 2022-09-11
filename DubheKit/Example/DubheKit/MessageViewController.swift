//
//  ViewController.swift
//  DubheKit
//
//  Created by LLLLLayer on 08/30/2022.
//  Copyright (c) 2022 LLLLLayer. All rights reserved.
//

import UIKit
import DubheKit

class MessageViewController: DubheViewController {
    
    override func componentNames(context: ComponentContext) -> [String] {
        [
            "DubheKit_Example.NavigationComponent",
            "DubheKit_Example.ListComponent",
            "DubheKit_Example.InputComponent",
        ]
    }
    
    override func lazyComponentNames(context: ComponentContext) -> [String] {
        [
            "DubheKit_Example.TipsComponent",
        ]
    }
}

