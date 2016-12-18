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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(titleLabel)
        addSubview(cellIcon)

        initCellLayout()
    }

    private func initCellLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }

        cellIcon.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(20)
            make.top.equalTo(snp.top).offset(10)
            make.bottom.equalTo(snp.bottom).offset(-10)
            make.width.equalTo(cellIcon.snp.height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Class Methods
extension HYAlertCell {
    class var ID: String {
        return "HYAlertCell"
    }

    class var cellHeight: CGFloat {
        return HYConstants.alertCellheight
    }
}
