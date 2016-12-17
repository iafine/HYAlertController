//
//  HYActionSheetView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYActionSheetViewDelegate: class {
    /// 点击事件
    func clickSheetItemHandler()
}

class HYActionSheetView: UIView {

    lazy var sheetTable: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()

    lazy var titleView: HYTitleView = {
        return HYTitleView(frame: .zero)
    }()

    var sheetTitle: String?
    var sheetMessage: String?
    weak var delegate: HYActionSheetViewDelegate?
    fileprivate var sheetDataArray: [HYAlertAction] = []
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
extension HYActionSheetView {
    fileprivate func initUI() {
        sheetTable.delegate = self
        sheetTable.dataSource = self
        addSubview(self.sheetTable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        sheetTable.frame = bounds

        if sheetTitle != nil || sheetMessage != nil {
            titleView.refrenshTitleView(title: self.sheetTitle,
                message: sheetMessage)
            titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: sheetTitle,
                    message: sheetMessage,
                    width: bounds.width))
            sheetTable.tableHeaderView = titleView
        } else {
            sheetTable.tableHeaderView = UIView()
        }
    }
}

// MARK: - Public Methods
extension HYActionSheetView {
    open func refreshDate(dataArray: [HYAlertAction], cancelArray: [HYAlertAction], title: String?, message: String?) {
        sheetDataArray = dataArray
        cancelDataArray = cancelArray

        sheetTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYActionSheetView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sheetDataArray.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            let action = sheetDataArray[indexPath.row]
            cell.titleLabel.text = action.title
            if action.style == .destructive {
                cell.titleLabel.textColor = UIColor.red
            }
            cell.cellIcon.image = action.image
            return cell
        } else {
            let cell: HYAlertCell = HYAlertCell.cellWithTableView(tableView: tableView)
            if cancelDataArray.count > 0 {
                let action = cancelDataArray[indexPath.row]
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
extension HYActionSheetView: UITableViewDelegate {
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
            let action = sheetDataArray[indexPath.row]
            action.myHandler(action)
        } else {
            if !cancelDataArray.isEmpty {
                let action = cancelDataArray[indexPath.row]
                action.myHandler(action)
            }
        }
        delegate?.clickSheetItemHandler()
    }
}
