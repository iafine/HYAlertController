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
        let imageView: UIImageView = UIImageView()
        return imageView
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
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as! HYAlertCell?
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
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero

        addSubview(titleLabel)
        addSubview(cellIcon)
    }

    fileprivate func initCellLayout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }

        self.cellIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.width.equalTo(self.cellIcon.snp.height)
        }
    }
}
