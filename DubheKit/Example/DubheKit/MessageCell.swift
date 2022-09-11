//
//  MessageCell.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell, Identifiable {
    
    static let identifier = String(describing: MessageCell.self)
    
    static func size(message: Message) -> CGSize {
        NSString(string: message.text).boundingRect(
            with: CGSize(width: 180.0, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font : UIFont.systemFont(ofSize: 16.0, weight: .medium)],
            context: nil).size
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue.withAlphaComponent(0.3)
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(message: Message) {
        label.text = message.text
        let size = Self.size(message: message)
        
        bubbleView.frame = CGRect(
            x: UIScreen.main.bounds.width - size.width - 16.0 - 20.0,
            y: 2.0,
            width: size.width + 20.0,
            height: size.height + 20.0)
        
        label.frame = CGRect(
            x: 10.0,
            y: 10.0,
            width: size.width,
            height: size.height)
    }
    
}
