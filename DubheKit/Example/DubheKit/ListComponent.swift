//
//  ListComponent.swift
//  DubheKit_Example
//
//  Created by yangjie.layer on 2022/9/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import DubheKit

typealias DataSource = UICollectionViewDiffableDataSource<String, Message>
typealias Snapshot = NSDiffableDataSourceSnapshot<String, Message>

class ListComponent: BaseComponent {
    
    /// Message list
    private var messageList: [Message] = ListComponent.historyMessages
    
    /// DiffableDataSource
    private lazy var dataSource = makeDataSource()
    
    /// Message collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .gray.withAlphaComponent(0.2)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        return collectionView
    }()
    
    // MARK: - Override
    
    override class func component(for context: ComponentContext) -> BaseComponent {
        return ListComponent()
    }
}

// MARK: - DiffableDataSource

extension ListComponent {
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, message) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MessageCell.identifier,
                    for: indexPath) as? MessageCell
                cell?.config(message: message)
                return cell
            })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(["default"])
        snapshot.appendItems(messageList)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListComponent: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelSize = MessageCell.size(message: messageList[indexPath.item])
        return CGSize(width: UIScreen.main.bounds.size.width, height: labelSize.height + 24.0)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        context?.viewController?.view.endEditing(true)
    }
}

// MARK: - InputComponentAction

extension ListComponent: InputComponentAction {
    
    func originYWillChange(newValue: CGFloat, duration: TimeInterval) {
        var collectionViewFrame = self.collectionView.frame
        collectionViewFrame.size.height = newValue - 100
        UIView.animate(withDuration: duration) { [weak self] in
            self?.collectionView.frame = collectionViewFrame
        }
        self.collectionView.scrollToItem(
            at: IndexPath(item: self.messageList.count - 1, section: 0),
            at: .bottom,
            animated: true)
    }
}

// MARK: - ListComponentInterface

extension ListComponent: ListComponentInterface {
    
    func send(message: Message) {
        let tipsService = try? resolve(service: TipsComponentInterface.self)
        tipsService?.checkAndShowtips(message: message)
        messageList.append(message)
        applySnapshot(animatingDifferences: true)
        collectionView.scrollToItem(at: IndexPath(item: messageList.count - 1, section: 0), at: .bottom, animated: true)
    }
}

// MARK: - ComponentLifeCycle

extension ListComponent: ComponentLifeCycle {
    func didMounted(context: ComponentContext) {
        try? bind(service: ListComponentInterface.self, tagret: self)
    }
    
    func didAllMounted(context: ComponentContext) {
        // Observer
        observe(action: InputComponentAction.self)
    }
}

// MARK: - HostLifeCycle

extension ListComponent: HostLifeCycle {
    
    func hostViewDidLoad() {
        context?.viewController?.view.addSubview(collectionView)
        collectionView.frame = CGRect(
            x: 0.0,
            y: 100.0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - 100.0)
        applySnapshot()
    }
}

// MARK: - Constant

extension ListComponent {
    
    private static let historyMessages = [Message(text: "Hello!")]
}
