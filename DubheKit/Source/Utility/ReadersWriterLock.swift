//
//  ReadersWriterLock.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/9/4.
//

import Foundation

public final class ReadersWriterLock {
    private var lock: UnsafeMutablePointer<pthread_rwlock_t>
    
    public init() {
        self.lock = UnsafeMutablePointer.allocate(capacity: 1)
        pthread_rwlock_init(lock, nil)
    }
    
    deinit {
        pthread_rwlock_destroy(lock)
        lock.deinitialize(count: 1)
        lock.deallocate()
    }
    
    public func withReadLock<T>(body: () throws -> T) rethrows -> T {
        pthread_rwlock_rdlock(lock)
        defer {
            pthread_rwlock_unlock(lock)
        }
        return try body()
    }
    
    public func withWriteLock<T>(body: () throws -> T) rethrows -> T {
        pthread_rwlock_wrlock(lock)
        defer {
            pthread_rwlock_unlock(lock)
        }
        return try body()
    }
}
