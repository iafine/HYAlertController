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

    class func cellWithTableView(tableView: UITableView) -> HYShareTableViewCell {
        // 修改cell类型为定义类型
        var cell: HYShareTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? HYShareTableViewCell
        if cell == nil {
            cell = HYShareTableViewCell()
            cell?.initCellUI()
            cell?.initCellLayout()
        }
        return cell!
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

// MARK: - Private Methods
extension HYShareTableViewCell {
    fileprivate func initCellUI() {
        backgroundColor = UIColor.lightGray
        contentView.addSubview(collectionView)
    }

    fileprivate func initCellLayout() {
    }
}
