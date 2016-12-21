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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    var action: HYAlertAction? {
        didSet {
            textLabel?.text = action?.title
            imageView?.image = action?.image
            if action?.style == .destructive {
                textLabel?.textColor = UIColor.red
            }
        }
    }

    var cancelAction: HYAlertAction? {
        didSet {
            if let cancelAction = cancelAction {
                textLabel?.text = cancelAction.title
                imageView?.image = cancelAction.image
            } else {
                textLabel?.text = HYConstants.defaultCancelText
            }
        }
    }

    class var cellHeight: CGFloat {
        return HYConstants.alertCellheight
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.center.x = center.x
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
