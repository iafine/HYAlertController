//
//  HYShareView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareView: HYPickerView {

    fileprivate var shareActions: [[HYAlertAction]] = [[]]
    /// 存储各个collectionView的偏移量
    fileprivate var contentOffsetDictionary: [Int: CGFloat] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refresh(_ actions: [[HYAlertAction]], cancelAction: HYAlertAction?, title: String?, message: String?) {
        shareActions = actions
        self.cancelAction = cancelAction

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYShareView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareActions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return HYShareTableViewCell(style: .default, reuseIdentifier: HYShareTableViewCell.ID)
    }
}

// MARK: - UITableViewDelegate
extension HYShareView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (cancelAction != nil && shareActions.count == indexPath.row) ? 44 : HYShareTableViewCell.cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell = cell as? HYShareTableViewCell
        shareCell?.textLabel?.text = (cancelAction != nil && shareActions.count == indexPath.row) ? cancelAction?.title : nil

        shareCell?.setCollectionViewDataSourceDelegate(collectionDataSource: self, collectionDelegate: self, indexPath: indexPath)

        let index = shareCell?.collectionView.tag ?? 0
        if let horizontalOffset = contentOffsetDictionary[index] {
            shareCell?.collectionView.contentOffset = CGPoint(x: horizontalOffset, y: 0)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell = cell as? HYShareTableViewCell
        let index = shareCell?.collectionView.tag ?? 0
        let horizontalOffset = shareCell?.collectionView.contentOffset.x ?? 0
        contentOffsetDictionary[index] = horizontalOffset
    }
}

// MARK: - UICollectionViewDelegate
extension HYShareView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionDataArray = shareActions[collectionView.tag]

        let action = collectionDataArray[indexPath.row]
        action.myHandler(action)

        delegate?.clickItemHandler()
    }
}

// MARK: - UICollectionViewDataSource
extension HYShareView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareActions[section].count + (cancelAction != nil ? 1 : 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HYShareCollectionCell.ID, for: indexPath) as? HYShareCollectionCell

        let collectionDataArray = shareActions[collectionView.tag]

        let action = collectionDataArray[indexPath.row]
        cell?.cellIcon.image = action.image
        cell?.titleView.text = action.title
        return cell!
    }
}

// MARK: - Events
extension HYShareView {
    @objc fileprivate func clickedCancelBtnHandler() {
        if let cancelAction = cancelAction {
            cancelAction.myHandler(cancelAction)
        }
        delegate?.clickItemHandler()
    }
}
