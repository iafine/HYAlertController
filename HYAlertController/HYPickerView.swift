//
//  HYPickerView.swift
//  HYAlertControllerDemo
//
//  Created by 伯驹 黄 on 2016/12/17.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

protocol HYActionDelegate: class {
    /// 点击事件
    func clickItemHandler()
}

class HYPickerView: UIView {
    var title: String?
    var message: String?
    weak var delegate: HYActionDelegate?

    static func pickerView(for style: HYAlertControllerStyle) -> HYPickerView {
        var pickerView: HYPickerView!

        switch style {
        case .actionSheet:
            pickerView = HYSheetView(frame: .zero)
        case .shareSheet:
            pickerView = HYShareView(frame: .zero)
        case .alert:
            pickerView = HYAlertView(frame: .zero)
        }
        return  pickerView
    }
}
