//
//  HYShareCollectionCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareCollectionCell: UICollectionViewCell {
    lazy var cellIcon: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        return imageView
    }()
    
    lazy var titleView: UITextView = {
        let text: UITextView = UITextView ()
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 11)
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCellUI()
        initCellLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Class Methods
extension HYShareCollectionCell {
    class func ID() -> String {
        return "HYShareCollectionCell"
    }
    
    class func cellSize() -> CGSize {
        return CGSize (width: HY_Constants.shareItemWidth, height: HY_Constants.shareItemHeight)
    }
    
    class func cellInset() -> UIEdgeInsets {
        return UIEdgeInsets (top: HY_Constants.shareItemPadding, left: HY_Constants.shareItemPadding, bottom: HY_Constants.shareItemPadding, right: HY_Constants.shareItemPadding)
    }
}

// MARK: - Private Methods
extension HYShareCollectionCell {
    fileprivate func initCellUI() {
        self.addSubview(self.titleView)
        self.addSubview(self.cellIcon)
    }
    
    fileprivate func initCellLayout() {
        self.cellIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(self.cellIcon.snp.width)
        }
        
        self.titleView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.cellIcon.snp.bottom).offset(5)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
