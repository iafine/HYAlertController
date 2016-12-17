//
//  HYShareView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYShareViewDelegate: class {
    // 点击分享item事件
    func clickedShareItemHandler()
}
class HYShareView: UIView {

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

    lazy var titleView: HYTitleView = {
        return HYTitleView(frame: .zero)
    }()

    var shareTitle: String?
    var shareMessage: String?
    weak var delegate: HYShareViewDelegate?
    fileprivate var shareDataArray: [[HYAlertAction]] = [[]]
    fileprivate var cancelDataArray: [HYAlertAction] = []
    /// 存储各个collectionView的偏移量
    fileprivate var contentOffsetDictionary: [Int: CGFloat] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYShareView {
    fileprivate func initUI() {
        shareTable.delegate = self
        shareTable.dataSource = self
        shareTable.tableFooterView = cancelButton
        addSubview(shareTable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shareTable.frame = bounds

        if shareTitle != nil || shareMessage != nil {
            titleView.refrenshTitleView(title: shareTitle,
                message: shareMessage)
            titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: self.shareTitle,
                    message: shareMessage,
                    width: bounds.width))
            shareTable.tableHeaderView = titleView
        } else {
            shareTable.tableHeaderView = UIView()
        }
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refreshData(dataArray: [[HYAlertAction]], cancelArray: [HYAlertAction], title: String?, message: String?) {
        shareDataArray = dataArray
        cancelDataArray = cancelArray

        shareTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYShareView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYShareTableViewCell.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

        delegate?.clickedShareItemHandler()
    }
}

// MARK: - UICollectionViewDataSource
extension HYShareView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareDataArray[section].count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
        if !cancelDataArray.isEmpty {
            let action = cancelDataArray[0]
            action.myHandler(action)
        }
        delegate?.clickedShareItemHandler()
    }
}
