//
//  HYSheetView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYSheetView: HYPickerView, DataPresenter {

    lazy var sheetTable: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
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
        if sheetTable.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            sheetTable.separatorInset = .zero
        }
        if sheetTable.responds(to: #selector(setter: UIView.layoutMargins)) {
            sheetTable.layoutMargins = .zero
        }
        sheetTable.delegate = self
        sheetTable.dataSource = self
        addSubview(sheetTable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYSheetView {

    override func layoutSubviews() {
        super.layoutSubviews()

        sheetTable.frame = bounds

        if title != nil || message != nil {
            titleView.refrenshTitleView(title: title,
                message: message)
            titleView.frame = CGRect(x: 0,
                y: 0,
                width: bounds.width,
                height: HYTitleView.titleViewHeight(title: title,
                    message: message,
                    width: bounds.width))
            sheetTable.tableHeaderView = titleView
        } else {
            sheetTable.tableHeaderView = UIView()
        }
    }
}

// MARK: - UITableViewDataSource
extension HYSheetView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? actions.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HYAlertCell(style: .value1, reuseIdentifier: HYAlertCell.ID)
        if indexPath.section == 0 {
            cell.action = actions[indexPath.row]
        } else {
            cell.cancelAction = cancelAction
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HYSheetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = .zero
        }
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
