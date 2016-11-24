//
//  HYShareView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYShareViewDelegate {
    // 点击分享item事件
    func clickedShareItemHandler()
}
class HYShareView: UIView {

    lazy var shareTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect.zero, style: .plain)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var cancelButton: UIButton = {
        let button: UIButton = UIButton (type: UIButtonType.custom)
        button.frame = CGRect (x: 0, y: 0, width: HY_Constants.ScreenWidth, height: 44)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector (clickedCancelBtnHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var titleView: HYTitleView = {
        let view: HYTitleView = HYTitleView (frame: CGRect.zero)
        return view
    }()
    
    var shareTitle: String = String ()
    var shareMessage: String = String ()
    var delegate: HYShareViewDelegate?
    fileprivate var shareDataArray: NSArray = NSArray ()
    fileprivate var cancelDataArray: NSArray = NSArray ()
    /// 存储各个collectionView的偏移量
    fileprivate var contentOffsetDictionary: NSMutableDictionary = NSMutableDictionary ()
    
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
        self.shareTable.delegate = self
        self.shareTable.dataSource = self
        self.shareTable.tableFooterView = self.cancelButton
        self.addSubview(self.shareTable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shareTable.frame = self.bounds
        
        if self.shareTitle.characters.count > 0 || self.shareMessage.characters.count > 0 {
            self.titleView.refrenshTitleView(title: self.shareTitle,
                                             message: self.shareMessage)
            self.titleView.frame = CGRect (x: 0,
                                           y: 0,
                                           width: self.bounds.size.width,
                                           height: HYTitleView.titleViewHeight(title: self.shareTitle,
                                                                               message: self.shareMessage,
                                                                               width: self.bounds.size.width))
            self.shareTable.tableHeaderView = self.titleView
        }else {
            self.shareTable.tableHeaderView = UIView ()
        }
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refreshDate(dataArray: NSArray, cancelArray: NSArray, title: String, message: String) {
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
        let shareCell: HYShareTableViewCell = cell as! HYShareTableViewCell
        shareCell.setCollectionViewDataSourceDelegate(collectionDataSource: self, collectionDelegate: self, indexPath: indexPath as NSIndexPath)
        
        let index: Int = shareCell.collectionView.tag
        if let horizontalOffset: CGFloat = self.contentOffsetDictionary.object(forKey: index) as? CGFloat {
            shareCell.collectionView.contentOffset = CGPoint (x: horizontalOffset, y: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell: HYShareTableViewCell = cell as! HYShareTableViewCell
        let index: Int = shareCell.collectionView.tag
        let horizontalOffset: CGFloat = shareCell.collectionView.contentOffset.x
        self.contentOffsetDictionary.setObject(horizontalOffset, forKey: index as NSCopying)
    }
}

// MARK: - UICollectionViewDelegate
extension HYShareView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionDataArray: NSArray = self.shareDataArray.object(at: collectionView.tag) as! NSArray
        
        let action: HYAlertAction = collectionDataArray.object(at: indexPath.row) as! HYAlertAction
        action.myHandler(action)
        
        delegate?.clickedShareItemHandler()
    }
}

// MARK: - UICollectionViewDataSource
extension HYShareView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionDataArray: NSArray = self.shareDataArray.object(at: section) as! NSArray
        return collectionDataArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HYShareCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYShareCollectionCell.ID(), for: indexPath) as! HYShareCollectionCell
        
        let collectionDataArray: NSArray = self.shareDataArray.object(at: collectionView.tag) as! NSArray
        
        let action: HYAlertAction = collectionDataArray.object(at: indexPath.row) as! HYAlertAction
        cell.cellIcon.image = action.image
        cell.titleView.text = action.title
        return cell
    }
}

// MARK: - Events
extension HYShareView {
    @objc fileprivate func clickedCancelBtnHandler() {
        if self.cancelDataArray.count > 0 {
            let action: HYAlertAction = self.cancelDataArray.object(at: 0) as! HYAlertAction
            action.myHandler(action)
        }
        delegate?.clickedShareItemHandler()
    }
}
