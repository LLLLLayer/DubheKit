//
//  ComponentEventMultiCast.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import Foundation

public class ComponentEventMultiCast {
    
    private let rwLock = ReadersWriterLock()
    
    public var targets: NSPointerArray = NSPointerArray(options: .weakMemory)
    
    func add(component: BaseComponent?) {
        guard let component = component else { return }
        rwLock.withReadLock {
            targets.addObject(component)
        }
    }
    
    func contain(component: BaseComponent?) -> Bool {
        guard let component = component else { return false }
        var contain: Bool = false
        rwLock.withReadLock {
            contain = targets.containObject(component)
        }
        return contain
    }
}

fileprivate extension NSPointerArray {
    
    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else { return }
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }
    
    func containObject(_ object: AnyObject?) -> Bool {
        guard let strongObject = object else { return false }
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        return allObjects.contains {
            pointer == $0 as? UnsafeMutableRawPointer ?? nil
        }
    }
}
