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
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HYShareCollectionCell.self, forCellWithReuseIdentifier: HYShareCollectionCell.ID)
        collection.backgroundColor = UIColor.white
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    var actions: [HYAlertAction]? {
        didSet {
            if actions != nil {
                collectionView.reloadData()
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        contentView.addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textAlignment = .center
        textLabel?.center.x = center.x

        collectionView.frame = contentView.bounds
    }
}

extension HYShareTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: HYShareCollectionCell.ID, for: indexPath)
    }
}

extension HYShareTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? HYShareCollectionCell)?.action = actions?[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - Class Methods
extension HYShareTableViewCell {

    class var cellHeight: CGFloat {
        return HYConstants.shareItemHeight + HYConstants.shareItemPadding * 2
    }
}
