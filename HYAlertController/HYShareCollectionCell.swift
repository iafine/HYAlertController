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
        return UIButton()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
