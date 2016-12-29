//
//  HYShareCollectionCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareCollectionCell: UICollectionViewCell {

    private lazy var button: UIButton = {
        let button = UIButton(frame: self.bounds)
        button.isUserInteractionEnabled = false
        button.setTitleColor( UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(button)
    }

    var action: HYAlertAction? {
        didSet {
            button.set(action?.title, with: action?.image)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.imageView?.bounds = CGRect (x: 0,
                                           y: 0,
                                           width: HYConstants.shareImageSize.width,
                                           height: HYConstants.shareImageSize.height)
    }
}

// MARK: - Class Methods
extension HYShareCollectionCell {
    class var ID: String {
        return "HYShareCollectionCell"
    }

    class var cellSize: CGSize {
        return CGSize(width: HYConstants.shareItemWidth, height: HYConstants.shareItemHeight)
    }

    class var cellInset: UIEdgeInsets {
        return UIEdgeInsets(top: HYConstants.shareItemPadding, left: HYConstants.shareItemPadding, bottom: HYConstants.shareItemPadding, right: HYConstants.shareItemPadding)
    }
}
