//
//  HYAlertView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYAlertViewDelegate: class {
    /// 点击事件
    func clickAlertItemHandler()
}

class HYAlertView: UIView {

    lazy var alertTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()

    lazy var titleView: HYTitleView = {
        return HYTitleView(frame: .zero)
    }()

    var alertTitle = ""
    var alertMessage = ""
    weak var delegate: HYAlertViewDelegate?
    fileprivate var alertDataArray: [HYAlertAction] = []
    fileprivate var cancelDataArray: [HYAlertAction] = []

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
        alertTable.delegate = self
        alertTable.dataSource = self
        addSubview(self.alertTable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if !alertTitle.isEmpty || !alertMessage.isEmpty {
            self.titleView.refrenshTitleView(title: alertTitle,
                message: alertMessage)
            self.titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: alertTitle,
                    message: alertMessage,
                    width: bounds.width))
            alertTable.tableHeaderView = titleView
        } else {
            self.alertTable.tableHeaderView = UIView()
        }
        alertTable.frame = bounds
    }
}

// MARK: - Public Methods
extension HYAlertView {
    open func refreshDate(dataArray: [HYAlertAction], cancelArray: [HYAlertAction], title: String, message: String) {
        alertDataArray = dataArray
        cancelDataArray = cancelArray
        alertTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYAlertView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return alertDataArray.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            let action: HYAlertAction = alertDataArray[indexPath.row]
            cell.titleLabel.text = action.title
            if action.style == .destructive {
                cell.titleLabel.textColor = UIColor.red
            }
            cell.cellIcon.image = action.image
            return cell
        } else {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            if self.cancelDataArray.count > 0 {
                let action: HYAlertAction = cancelDataArray[indexPath.row]
                cell.titleLabel.text = action.title
                cell.cellIcon.image = action.image
            } else {
                cell.titleLabel.text = HYConstants.defaultCancelText
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension HYAlertView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYAlertCell.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            let action = alertDataArray[indexPath.row]
            action.myHandler(action)
        } else {
            if !cancelDataArray.isEmpty {
                let action = cancelDataArray[indexPath.row]
                action.myHandler(action)
            }
        }
        delegate?.clickAlertItemHandler()
    }
}
