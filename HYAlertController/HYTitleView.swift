//
//  HYTitleView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/17.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Header View
class HYTitleView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: HYConstants.titleFont)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: HYConstants.messageFont)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYTitleView {
    fileprivate func initUI() {
        titleLabel.backgroundColor = UIColor.red
        addSubview(titleLabel)
        addSubview(messageLabel)
    }

    fileprivate func initLayout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(5)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        self.messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}

// MARK: - Class Methods
extension HYTitleView {
    class func titleViewHeight(title: String?, message: String?, width: CGFloat) -> CGFloat {
        var titleHeight: CGFloat = 15
        if let title = title, title.isEmpty {
            titleHeight += title.heightWithConstrained(width: width - 40, font: UIFont.systemFont(ofSize: HYConstants.titleFont)) + 1
        }
        if let message = message, message.isEmpty {
            titleHeight += message.heightWithConstrained(width: width - 40, font: UIFont.systemFont(ofSize: HYConstants.messageFont)) + 1
        }
        return titleHeight
    }
}

// MARK: - Public Methods
extension HYTitleView {
    open func refrenshTitleView(title: String?, message: String?) {
        titleLabel.text = title
        messageLabel.text = message
    }
}

// MARK: - 根据文字计算高度
extension String {
    func heightWithConstrained(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return boundingBox.height
    }
}
