//
//  HYShareTableViewCell.swift
//  Quick-Start-iOS (含有UICollectionView的UITableViewCell)
//
//  Created by work on 2016/11/3.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareTableViewCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = HYShareCollectionCell.cellSize
        collectionLayout.sectionInset = HYShareCollectionCell.cellInset
        collectionLayout.scrollDirection = .horizontal
        let collection: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collection.register(HYShareCollectionCell.self, forCellWithReuseIdentifier: HYShareCollectionCell.ID)
        collection.backgroundColor = UIColor.white
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.lightGray
        contentView.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.frame = contentView.bounds
    }
}

// MARK: - Class Methods
extension HYShareTableViewCell {
    class var ID: String {
        return "HYShareTableViewCell"
    }

    class var cellHeight: CGFloat {
        return HYConstants.shareItemHeight + HYConstants.shareItemPadding * 2
    }
}

// MARK: - Public Methods
extension HYShareTableViewCell {
    func setCollectionViewDataSourceDelegate(collectionDataSource: UICollectionViewDataSource, collectionDelegate: UICollectionViewDelegate, indexPath: IndexPath) {
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
        collectionView.tag = indexPath.row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)

        collectionView.reloadData()
    }
}
