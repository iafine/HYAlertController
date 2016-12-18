//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYAlertControllerStyle: Int {

    case actionSheet

    case shareSheet

    case alert
}

// MARK: - Class
public class HYAlertController: UIViewController {

    var alertTitle: String?
    var alertMessage: String?
    var alertStyle = HYAlertControllerStyle.alert

    fileprivate var actionArray: [[HYAlertAction]] = []
    fileprivate var cancelAction: HYAlertAction?

    var alertHeight: CGFloat = 0

    var pickerView: HYPickerView!

    lazy var dimBackgroundView: UIControl = {
        let control = UIControl(frame: CGRect(x: 0,
            y: 0,
            width: HYConstants.ScreenWidth,
            height: HYConstants.ScreenHeight))
        control.backgroundColor = UIColor(white: 0, alpha: HYConstants.dimBackgroundAlpha)
        control.addTarget(self, action: #selector(clickedBgViewHandler), for: .touchDown)
        return control
    }()

    convenience init(title: String?, message: String?, style: HYAlertControllerStyle) {
        self.init()

        alertTitle = title
        alertMessage = message
        alertStyle = style

        // 自定义转场动画
        transitioningDelegate = self
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical

        pickerView = HYPickerView.pickerView(for: alertStyle)
        pickerView.delegate = self
        view.addSubview(pickerView)
    }
}

// MARK: - LifeCycle
extension HYAlertController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(dimBackgroundView)
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.title = alertTitle
        pickerView.message = alertMessage
        if alertStyle == .shareSheet {
            var tableHeight = HYShareTableViewCell.cellHeight * CGFloat(actionArray.count) + 44
            if alertTitle != nil || alertMessage != nil {
                tableHeight += HYTitleView.titleViewHeight(title: alertTitle,
                    message: alertMessage,
                    width: HYConstants.ScreenWidth)
            }
            let newTableFrame = CGRect(x: 0,
                y: HYConstants.ScreenHeight - tableHeight,
                width: HYConstants.ScreenWidth,
                height: tableHeight)
            alertHeight = tableHeight
            pickerView.frame = newTableFrame
        } else if alertStyle == .actionSheet {
            var tableHeight = HYAlertCell.cellHeight * CGFloat(actionArray[0].count) + HYAlertCell.cellHeight + 10
            if alertTitle != nil || alertMessage != nil {
                tableHeight += HYTitleView.titleViewHeight(title: alertTitle,
                    message: alertMessage,
                    width: HYConstants.ScreenWidth)
            }
            let newTableFrame = CGRect(x: 0,
                y: HYConstants.ScreenHeight - tableHeight,
                width: HYConstants.ScreenWidth,
                height: tableHeight)
            alertHeight = tableHeight
            pickerView.frame = newTableFrame
        } else {
            var tableHeight = HYAlertCell.cellHeight * CGFloat(actionArray[0].count) + HYAlertCell.cellHeight + 10
            if alertTitle != nil || alertMessage != nil {
                tableHeight += HYTitleView.titleViewHeight(title: alertTitle,
                    message: alertMessage,
                    width: HYConstants.ScreenWidth - HYConstants.alertSpec)
            }
            let newTableFrame = CGRect(x: 0,
                y: 0,
                width: HYConstants.ScreenWidth - HYConstants.alertSpec,
                height: tableHeight)
            alertHeight = tableHeight
            pickerView.frame = newTableFrame
            pickerView.center = view.center
        }
    }
}

// MARK: - Public Methods
extension HYAlertController {
    open func add(_ action: HYAlertAction) {
        if action.style == .cancel {
            cancelAction = action
        } else {
            if actionArray.isEmpty {
                actionArray.append([action])
            } else {
                actionArray[0].append(action)
            }
        }
        (pickerView as? DataPresenter)?.refresh(actionArray[0], cancelAction: cancelAction, title: alertTitle, message: alertMessage)
    }

    /// 添加必须是元素为HYAlertAction的数组，调用几次该方法，分享显示几行
    open func addShare(_ actions: [HYAlertAction]) {
        actionArray += [actions]
        (pickerView as? HYShareView)?.refresh(actionArray, cancelAction: cancelAction, title: alertTitle, message: alertMessage)
    }
}

// MARK: - HYSheetViewDelegate
extension HYAlertController: HYActionDelegate {
    func clickItemHandler() {
        dismiss()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension HYAlertController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertPresentSlideUp()
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertDismissSlideDown()
    }
}

// MARK: - Events
extension HYAlertController {

    /// 点击背景事件
    @objc fileprivate func clickedBgViewHandler() {
        dismiss()
    }
}

// MARK: - Private Methods
extension HYAlertController {
    // 取消视图显示和控制器加载
    fileprivate func dismiss() {
        actionArray.removeAll()
        cancelAction = nil

        dismiss(animated: true, completion: nil)
    }
}
