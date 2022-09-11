//
//  InputComponent.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/8/31.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import DubheKit

class InputComponent: BaseComponent {
    
    // MARK: - Property
    
    let inputView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0.0,
            y: UIScreen.main.bounds.height - 50.0,
            width: UIScreen.main.bounds.height,
            height: 50.0))
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField(frame: CGRect(
            x: 16.0,
            y: 10.0,
            width: UIScreen.main.bounds.width - 78.0,
            height: 30.0))
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        textField.layer.cornerRadius = 4.0
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(
            x: UIScreen.main.bounds.width - 46.0,
            y: 10,
            width: 30.0,
            height: 30.0)
        button.setImage(UIImage.init(systemName: "paperplane.fill"), for: .normal)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15.0
        return button
    }()
    
    var safeAreaInsetBottom: CGFloat {
        context?.viewController?.view.safeAreaInsets.bottom ?? 0
    }
    
    var listService: ListComponentInterface?
    
    @objc private func send(button: UIButton) {
        inputTextField.resignFirstResponder()
        if let text = inputTextField.text {
            listService?.send(message: Message(text: text))
            inputTextField.text = nil
        }
    }
    
    // MARK: - Override
    
    override class func enableCreateComponent(context: ComponentContext) -> Bool {
        print("Check enable create InputComponent")
        return true
    }
    
    override class func component(for context: ComponentContext) -> BaseComponent {
        print("Create InputComponent")
        return InputComponent()
    }
}

// MARK: - Publisher

extension InputComponent {
    
    func originYWillChange(newValue: CGFloat, duration: TimeInterval) {
        publish(action: InputComponentAction.self) { component in
            component.originYWillChange(newValue: newValue, duration: duration)
        }
    }
}

// MARK: - UITextFieldDelegate

extension InputComponent: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        publish(action: InputComponentAction.self) { component in
            component.update(state: InputState.input)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        publish(action: InputComponentAction.self) { component in
            component.update(state: InputState.input)
        }
    }
}

// MARK: - ComponentLifeCycle

extension InputComponent: ComponentLifeCycle {
    class func willMounted(context: ComponentContext) {
        print("InputComponent reveived `willMounted`")
    }
    
    func didMounted(context: ComponentContext) {
        print("InputComponent reveived `didMounted`")
    }
    
    func didAllMounted(context: ComponentContext) {
        print("InputComponent reveived `didAllMounted`")
        listService = try? resolve(service: ListComponentInterface.self)
    }
}

// MARK: - NotificationCenterObserver

extension InputComponent: NotificationCenterObserver {
    
    func keyboardWillChangeFrame(notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0
        var inputViewframe = self.inputView.frame
        inputViewframe.origin.y = UIScreen.main.bounds.height - 50.0 - height
        UIView.animate(withDuration: duration) {
            self.inputView.frame = inputViewframe
        }
        originYWillChange(newValue: inputView.frame.origin.y, duration: duration)
    }
    
    func keyboardWillHide(notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0
        var inputViewframe = self.inputView.frame
        inputViewframe.origin.y = UIScreen.main.bounds.height - (50.0 + self.safeAreaInsetBottom)
        UIView.animate(withDuration: duration) {
            self.inputView.frame = inputViewframe
        }
        originYWillChange(newValue: inputView.frame.origin.y, duration: duration)
    }
}

// MARK: - HostLifeCycle

extension InputComponent: HostLifeCycle {
    
    func hostViewDidLoad() {
        print("InputComponent reveived `hostViewDidLoad`")
        
        // Add inputView
        context?.viewController?.view.addSubview(inputView)
        
        // Add inputTextField
        inputView.addSubview(inputTextField)
        inputTextField.delegate = self
        
        // Add sendButton
        inputView.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(send(button:)), for: .touchUpInside)
    }

    func hostViewWillAppear() {
        print("InputComponent reveived `hostViewDidLoad`")
    }

    func hostViewDidAppear() {
        print("InputComponent reveived `hostViewDidLoad`")
        
        // Adjust inputView
        var inputViewFrame = inputView.frame
        inputViewFrame.origin.y -= safeAreaInsetBottom
        inputViewFrame.size.height += safeAreaInsetBottom
        inputView.frame = inputViewFrame
        originYWillChange(newValue: inputView.frame.origin.y, duration: 0.0)
    }

    func hostViewWillDisappear() {
        print("InputComponent reveived `hostViewDidLoad`")
    }

    func hostViewDidDisappear() {
        print("InputComponent reveived `hostViewDidLoad`")
    }
}
