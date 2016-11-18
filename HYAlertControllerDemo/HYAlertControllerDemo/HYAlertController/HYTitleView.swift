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
        let label: UILabel = UILabel ()
        label.font = UIFont.systemFont(ofSize: HY_Constants.titleFont)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont.systemFont(ofSize: HY_Constants.messageFont)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var seperatorView: UIView = {
        let view: UIView = UIView ()
        view.backgroundColor = UIColor (red: 206 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
        return view
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.messageLabel)
//        self.addSubview(self.seperatorView)
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
//        self.seperatorView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.snp.left)
//            make.bottom.equalTo(self.snp.bottom)
//            make.right.equalTo(self.snp.right)
//            make.height.equalTo(0.5)
//        }
    }
}

// MARK: - Class Methods
extension HYTitleView {
    class func titleViewHeight(title: String, message: String, width: CGFloat) -> CGFloat {
        var titleHeight: CGFloat = 15
        if title.characters.count > 0 {
            titleHeight += title.heightWithConstrainedWidth(width: width - 40, font: UIFont.systemFont(ofSize: HY_Constants.titleFont)) + 1
        }
        if message.characters.count > 0 {
            titleHeight += message.heightWithConstrainedWidth(width: width - 40, font: UIFont.systemFont(ofSize: HY_Constants.messageFont)) + 1
        }
        return titleHeight
    }
}

// MARK: - Public Methods
extension HYTitleView {
    open func refrenshTitleView(title: String, message: String) {
        self.titleLabel.text = title
        self.messageLabel.text = message
    }
}

// MARK: - 根据文字计算高度
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
