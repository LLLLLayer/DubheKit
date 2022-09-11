//
//  DubheViewController.swift
//  DubheKit
//
//  Created by yangjie.layer on 2022/8/30.
//

import UIKit

/// The UIViewController of the business side inherits from this class and maintains componentized logic internally
open class DubheViewController: UIViewController {
    
    // MARK: - Property
    
    /// Component manager
    public var componentManager: ComponentManager?
    
    // MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - LifeCycle
    
    ///  Called after the view has been loaded
    open override func viewDidLoad() {
        self.componentManager = createComponentManager()
        self.componentManager?.isRoot = isRootComponent()
        self.componentManager?.resolveComponents()
        super.viewDidLoad()
        addNotificationCenterObserver()
        componentManager?.hostViewDidLoad()
    }
    
    /// Called when the view is about to made visible
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        componentManager?.hostViewWillAppear()
    }
    
    /// Called when the view has been fully transitioned onto the screen
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        componentManager?.hostViewDidAppear()
    }
    
    /// Called when the view is dismissed, covered or otherwise hidden
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        componentManager?.hostViewWillDisappear()
    }
    
    /// Called after the view was dismissed, covered or otherwise hidden
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        componentManager?.hostViewDidDisappear()
    }
    
    // MARK: - Methods that need to be overridden
    
    /// Override this method to provide components that need to be loaded
    ///
    /// - Attention: Although not required, it is better to override it
    open func componentNames(context: ComponentContext) -> [String] {
        []
    }
    
    /// Override this method to provide components that need lazy loading
    ///
    /// - Note: Please override this method when necessary
    open func lazyComponentNames(context: ComponentContext) -> [String] {
        []
    }
    
    ///  Override the context provided by this method
    ///
    /// - Note: Please override this method when necessary
    open func componentContext() -> ComponentContext {
        let context = ComponentContext(viewController: self)
        return context
    }
    
    /// Create component manager
    ///
    /// - Note: If you want to provide component manager in other ways, please override this method
    open func createComponentManager() -> ComponentManager {
        ComponentManager(dependency: self)
    }
    
    /// Is the current root node
    ///
    /// - Note: Use with custom component // MARK: - anager if needed
    open func isRootComponent() -> Bool {
        true
    }
    
    // MARK: - AppLifecycle
    
    /// Add observation for AppLifeCycle
    ///
    /// - Note: Check out AppLifeCycle to see how much capabilities the framework provides, rewrite when needed
    open func addNotificationCenterObserver() {
        addDefaultNotificationCenterObserver()
    }
}

// MARK: - ComponentContainer

extension DubheViewController: ComponentContainer {}

// MARK: - ComponentManagerDependency

extension DubheViewController: ComponentManagerDependency {}

// MARK: - NotificationCenterObserver

extension DubheViewController {
    
    func addDefaultNotificationCenterObserver() {
        
        // -- Enter background or foreground--
        
        // UIApplicationDidEnterBackground
        NotificationCenter.default.addObserver(
            forName: .UIApplicationDidEnterBackground,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.applicationDidEnterBackground(notification: notification)
            }
        
        // UIApplicationWillEnterForeground
        NotificationCenter.default.addObserver(
            forName: .UIApplicationWillEnterForeground,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.applicationWillEnterForeground(notification: notification)
            }
        
        // -- Keyboard --
        
        // UIKeyboardWillShow
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillShow,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardWillShow(notification: notification)
            }
        
        // UIKeyboardDidShow
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardDidShow,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardDidShow(notification: notification)
            }
        
        // UIKeyboardWillHide
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillHide,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardWillHide(notification: notification)
            }
        
        // UIKeyboardDidHide
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardDidHide,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardDidHide(notification: notification)
            }
        
        // UIKeyboardWillChangeFrame
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillChangeFrame,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardWillChangeFrame(notification: notification)
            }
        
        // UIKeyboardDidChangeFrame
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardDidChangeFrame,
            object: nil,
            queue: OperationQueue.main) { [weak self] notification in
                self?.componentManager?.keyboardDidChangeFrame(notification: notification)
            }
    }
}
