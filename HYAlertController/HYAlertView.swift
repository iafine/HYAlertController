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
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()

    var actions: [HYAlertAction] = []
    var cancelAction: HYAlertAction?

    override init(frame: CGRect) {
        super.init(frame: frame)

        if alertTable.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            alertTable.separatorInset = .zero
        }
        if alertTable.responds(to: #selector(setter: UIView.layoutMargins)) {
            alertTable.layoutMargins = .zero
        }

        alertTable.delegate = self
        alertTable.dataSource = self
        addSubview(alertTable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYAlertView {

    override func layoutSubviews() {
        super.layoutSubviews()

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
