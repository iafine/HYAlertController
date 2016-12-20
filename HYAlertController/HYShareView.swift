//
//  HYShareView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareView: HYPickerView {

    lazy var shareTable: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.isScrollEnabled = false
        return tableView
    }()

    lazy var cancelButton: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: HYConstants.ScreenWidth, height: 44)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(clickedCancelBtnHandler), for: .touchUpInside)
        return button
    }()

    fileprivate var shareDataArray: [[HYAlertAction]] = [[]]
    fileprivate var cancelAction: HYAlertAction?
    /// 存储各个collectionView的偏移量
    fileprivate var contentOffsetDictionary: [Int: CGFloat] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)

        shareTable.delegate = self
        shareTable.dataSource = self
        shareTable.tableFooterView = cancelButton
        addSubview(shareTable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYShareView {

    override func layoutSubviews() {
        super.layoutSubviews()

        shareTable.frame = bounds
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refresh(_ actions: [[HYAlertAction]], cancelAction: HYAlertAction?, title: String?, message: String?) {
        shareDataArray = actions
        self.cancelAction = cancelAction

        shareTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYShareView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HYShareTableViewCell.cellWithTableView(tableView: tableView)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HYShareView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYShareTableViewCell.cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell = cell as? HYShareTableViewCell
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
        let collectionDataArray = shareDataArray[collectionView.tag]

        let action = collectionDataArray[indexPath.row]
        action.myHandler(action)

        delegate?.clickItemHandler()
    }
}

// MARK: - UICollectionViewDataSource
extension HYShareView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareDataArray[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HYShareCollectionCell.ID, for: indexPath) as? HYShareCollectionCell

        let collectionDataArray = shareDataArray[collectionView.tag]

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
