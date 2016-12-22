//
//  HYPickerView.swift
//  HYAlertControllerDemo
//
//  Created by 伯驹 黄 on 2016/12/17.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

protocol HYActionDelegate: class {
    /// 点击事件
    func clickItemHandler()
}

class HYPickerView: UIView {
    var title: String?
    var message: String?
    weak var delegate: HYActionDelegate?

    var cancelAction: HYAlertAction?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = .zero
        }

        addSubview(tableView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }

    final func set(title: String?, message: String?) {
        if title == nil && message == nil { return }
        let headerView = HYTitleView(width: bounds.width, title: title, message: message)
        frame.size.height += headerView.frame.height
        frame.origin.y -= headerView.frame.height
        tableView.tableHeaderView = headerView
    }

    static func pickerView(for style: HYAlertControllerStyle) -> HYPickerView {
        var pickerView: HYPickerView!

        switch style {
        case .actionSheet, .alert:
            pickerView = HYAlertView(frame: .zero)
        case .shareSheet:
            pickerView = HYShareView(frame: .zero)
        }
        return  pickerView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HYTitleView: UIView {
    init(width: CGFloat, title: String?, message: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: width - 20, height: 0))
        titleLabel.numberOfLines = 0
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.frame.origin.x = (width - titleLabel.frame.width) / 2
        addSubview(titleLabel)

        let messageLabel = UILabel(frame: CGRect(x: 10, y: titleLabel.frame.maxY + 8, width: width - 20, height: 0))
        messageLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        messageLabel.textColor = UIColor(white: 0.8, alpha: 1)
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.sizeToFit()
        addSubview(messageLabel)

        frame.size.height = messageLabel.frame.height + titleLabel.frame.height + 28
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
