//
//  HYShareView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareView: HYPickerView {

    fileprivate var shareActions: [[HYAlertAction]] = [[]]
    /// 存储各个collectionView的偏移量
    fileprivate var contentOffsetDictionary: [Int: CGFloat] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension HYShareView {
    open func refresh(_ actions: [[HYAlertAction]]) {
        shareActions = actions

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYShareView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return cancelAction != nil ? 2 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? shareActions.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return HYShareTableViewCell(style: .default, reuseIdentifier: HYShareTableViewCell.ID)
    }
}

// MARK: - UITableViewDelegate
extension HYShareView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == IndexPath(row: 0, section: 1) ? 44 : HYShareTableViewCell.cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  indexPath == IndexPath(row: 0, section: 1) {
            cell.textLabel?.text = "取消"
        } else {
            let shareCell = cell as? HYShareTableViewCell

            shareCell?.actions = shareActions[indexPath.row]
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath == IndexPath(row: 0, section: 1) {

        }
    }
}

// MARK: - Events
extension HYShareView {
    @objc fileprivate func clickedCancelBtnHandler() {
//        cancelAction?.myHandler(cancelAction)
        delegate?.clickItemHandler()
    }
}
