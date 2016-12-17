//
//  HYAlertView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertView: HYPickerView, DataPresenter {

    lazy var alertTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()

    lazy var titleView: HYTitleView = {
        return HYTitleView(frame: .zero)
    }()

    var actions: [HYAlertAction] = []
    var cancelAction: HYAlertAction?

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
        addSubview(alertTable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if title != nil || message != nil {
            self.titleView.refrenshTitleView(title: title,
                message: message)
            self.titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: title,
                    message: message,
                    width: bounds.width))
            alertTable.tableHeaderView = titleView
        } else {
            alertTable.tableHeaderView = UIView()
        }
        alertTable.frame = bounds
    }
}


// MARK: - UITableViewDataSource
extension HYAlertView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? actions.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HYAlertCell.cellWithTableView(tableView: tableView)
        if indexPath.section == 0 {
            let action = actions[indexPath.row]
            cell.titleLabel.text = action.title
            cell.cellIcon.image = action.image
            if action.style == .destructive {
                cell.titleLabel.textColor = UIColor.red
            }
        } else {
            if let cancelAction = cancelAction {
                cell.titleLabel.text = cancelAction.title
                cell.cellIcon.image = cancelAction.image
            } else {
                cell.titleLabel.text = HYConstants.defaultCancelText
            }
        }
        return cell
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
            let action = actions[indexPath.row]
            action.myHandler(action)
        } else {
            if let cancelAction = cancelAction {
                cancelAction.myHandler(cancelAction)
            }
        }
        delegate?.clickItemHandler()
    }
}
