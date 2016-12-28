//
//  HYAlertView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertView: HYPickerView, DataPresenter {

    var actions: [HYAlertAction] = []

    fileprivate var isShowCancelCell: Bool {
        return cancelAction != nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = .zero
        }

        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension HYAlertView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShowCancelCell ? 2 : 1
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
extension HYAlertView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYAlertCell.cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = .zero
        }
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
