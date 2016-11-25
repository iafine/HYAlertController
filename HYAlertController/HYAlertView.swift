//
//  HYAlertView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYAlertViewDelegate {
    /// 点击事件
    func clickAlertItemHandler()
}

class HYAlertView: UIView {
    
    lazy var alertTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var titleView: HYTitleView = {
        let view: HYTitleView = HYTitleView (frame: CGRect.zero)
        return view
    }()
    
    var alertTitle: String = String ()
    var alertMessage: String = String ()
    var delegate: HYAlertViewDelegate?
    fileprivate var alertDataArray: NSArray = NSArray ()
    fileprivate var cancelDataArray: NSArray = NSArray ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYAlertView {
    fileprivate func initUI() {
        self.alertTable.delegate = self
        self.alertTable.dataSource = self
        self.addSubview(self.alertTable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
            self.titleView.refrenshTitleView(title: self.alertTitle,
                                             message: self.alertMessage)
            self.titleView.frame = CGRect (x: 0,
                                           y: 0,
                                           width: self.bounds.size.width,
                                           height: HYTitleView.titleViewHeight(title: self.alertTitle,
                                                                               message: self.alertMessage,
                                                                               width: self.bounds.size.width))
            self.alertTable.tableHeaderView = self.titleView
        }else {
            self.alertTable.tableHeaderView = UIView ()
        }
        self.alertTable.frame = self.bounds
    }
}

// MARK: - Public Methods
extension HYAlertView {
    open func refreshDate(dataArray: NSArray, cancelArray: NSArray, title: String, message: String) {
        self.alertDataArray = dataArray
        self.cancelDataArray = cancelArray
    
        self.alertTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYAlertView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.alertDataArray.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            let action: HYAlertAction = self.alertDataArray.object(at: indexPath.row) as! HYAlertAction
            cell.titleLabel.text = action.title
            if action.style == .destructive {
                cell.titleLabel.textColor = UIColor.red
            }
            cell.cellIcon.image = action.image
            return cell
        }else {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            if self.cancelDataArray.count > 0 {
                let action: HYAlertAction = self.cancelDataArray.object(at: indexPath.row) as! HYAlertAction
                cell.titleLabel.text = action.title
                cell.cellIcon.image = action.image
            }else {
                cell.titleLabel.text = HY_Constants.defaultCancelText
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension HYAlertView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYAlertCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let action: HYAlertAction = self.alertDataArray.object(at: indexPath.row) as! HYAlertAction
            action.myHandler(action)
        }else {
            if self.cancelDataArray.count > 0 {
                let action: HYAlertAction = self.cancelDataArray.object(at: indexPath.row) as! HYAlertAction
                action.myHandler(action)
            }
        }
        delegate?.clickAlertItemHandler()
    }
}

