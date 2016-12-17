//
//  HYAlertCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import SnapKit

class HYAlertCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkText
        return label
    }()

    lazy var cellIcon: UIImageView = {
        return UIImageView()
    }()
}

// MARK: - Class Methods
extension HYAlertCell {
    class var ID: String {
        return "HYAlertCell"
    }

    class var cellHeight: CGFloat {
        return HYConstants.alertCellheight
    }

    class func cellWithTableView(tableView: UITableView) -> HYAlertCell {
        // 修改cell类型为定义类型
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? HYAlertCell
        if cell == nil {
            cell = HYAlertCell()
            cell?.initCellUI()
            cell?.initCellLayout()
        }
        return cell!
    }
}

// MARK: - Private Methods
extension HYAlertCell {
    fileprivate func initCellUI() {

        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero

        addSubview(titleLabel)
        addSubview(cellIcon)
    }

    fileprivate func initCellLayout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }

        self.cellIcon.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(20)
            make.top.equalTo(snp.top).offset(10)
            make.bottom.equalTo(snp.bottom).offset(-10)
            make.width.equalTo(cellIcon.snp.height)
        }
    }
}
