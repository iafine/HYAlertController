//
//  HYShareCollectionCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareCollectionCell: UICollectionViewCell {

    fileprivate lazy var shareImageView: UIImageView = {
        let imageView = UIImageView (frame: CGRect (x: 15, y: 0, width: self.bounds.size.width - 30, height: self.bounds.size.width - 30))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate lazy var shareTitleLabel: UILabel = {
        let label = UILabel (frame: CGRect (x: 0, y: self.shareImageView.frame.maxY + 5, width: self.bounds.size.width, height: 20))
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(shareImageView)
        contentView.addSubview(shareTitleLabel)
    }

    var action: HYAlertAction? {
        didSet {
            self.shareImageView.image = action?.image
            self.shareTitleLabel.text = action?.title
        }
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

// MARK: - Layout Methods
extension HYShareCollectionCell {
    fileprivate func initLayout(title: String?, image: UIImage?) {
        
    }
}
