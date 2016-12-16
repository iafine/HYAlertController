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
        let view: HYTitleView = HYTitleView(frame: CGRect.zero)
        return view
    }()

    var shareTitle: String = String()
    var shareMessage: String = String()
    weak var delegate: HYShareViewDelegate?
    fileprivate var shareDataArray: [[HYAlertAction]] = []
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
        addSubview(self.shareTable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.shareTable.frame = self.bounds

        if self.shareTitle.characters.count > 0 || self.shareMessage.characters.count > 0 {
            self.titleView.refrenshTitleView(title: self.shareTitle,
                message: self.shareMessage)
            self.titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: self.shareTitle,
                    message: self.shareMessage,
                    width: self.bounds.size.width))
            self.shareTable.tableHeaderView = titleView
        } else {
            self.shareTable.tableHeaderView = UIView()
        }
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refreshDate(dataArray: [[HYAlertAction]], cancelArray: [HYAlertAction], title: String, message: String) {
        self.shareDataArray = dataArray
        self.cancelDataArray = cancelArray

        self.shareTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYShareView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shareDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HYShareTableViewCell = HYShareTableViewCell.cellWithTableView(tableView: tableView)
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
        return HYShareTableViewCell.cellHeight()
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
        let collectionDataArray = self.shareDataArray[collectionView.tag]

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
        if self.cancelDataArray.count > 0 {
            let action = self.cancelDataArray[0]
            action.myHandler(action)
        }
        delegate?.clickedShareItemHandler()
    }
}
