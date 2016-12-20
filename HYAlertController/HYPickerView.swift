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
