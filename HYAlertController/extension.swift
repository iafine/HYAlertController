//
//  HYTitleView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/17.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - 根据文字计算高度
extension String {
    func heightWithConstrained(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return boundingBox.height
    }
}
