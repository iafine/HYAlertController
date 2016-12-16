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

    var alertTitle: String
    var alertMessage: String
    var alertStyle: HYAlertControllerStyle

    fileprivate var actionArray: [[HYAlertAction]] = [[]]
    fileprivate var cancelActionArray: [HYAlertAction] = []

    var alertHeight: CGFloat = 0

    lazy var shareView: HYShareView = {
        return HYShareView(frame: .zero)
    }()

    lazy var sheetView: HYActionSheetView = {
        return HYActionSheetView(frame: .zero)
    }()

    lazy var alertView: HYAlertView = {
        return HYAlertView(frame: .zero)
    }()

    lazy var dimBackgroundView: UIView = {
        let view: UIView = UIView(frame: CGRect(x: 0,
            y: 0,
            width: HYConstants.ScreenWidth,
            height: HYConstants.ScreenHeight))
        view.backgroundColor = UIColor(white: 0, alpha: HYConstants.dimBackgroundAlpha)
        view.alpha = 0

        // 添加手势监听
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(clickedBgViewHandler))
        view.addGestureRecognizer(tapGR)
        return view
    }()

    public init(title: String?, message: String?, style: HYAlertControllerStyle) {
        alertTitle = title ?? ""
        alertMessage = message ?? ""
        alertStyle = style
        super.init(nibName: nil, bundle: nil)

        // 自定义转场动画
        transitioningDelegate = self
        modalPresentationStyle = UIModalPresentationStyle.custom
        modalTransitionStyle = UIModalTransitionStyle.coverVertical
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYAlertController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear

        initUI()
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if self.alertStyle == .shareSheet {
            var tableHeight = HYShareTableViewCell.cellHeight * CGFloat(actionArray.count) + 44
            if !alertTitle.isEmpty || !alertMessage.isEmpty {
                tableHeight += HYTitleView.titleViewHeight(title: alertTitle,
                    message: alertMessage,
                    width: HYConstants.ScreenWidth)
            }
            let newTableFrame: CGRect = CGRect(x: 0,
                y: HYConstants.ScreenHeight - tableHeight,
                width: HYConstants.ScreenWidth,
                height: tableHeight)
            self.alertHeight = tableHeight
            self.shareView.shareTitle = self.alertTitle
            self.shareView.shareMessage = self.alertMessage
            self.shareView.frame = newTableFrame
        } else if self.alertStyle == .actionSheet {
            var tableHeight: CGFloat = HYAlertCell.cellHeight * CGFloat(self.actionArray.count) + HYAlertCell.cellHeight + 10
            if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
                tableHeight += HYTitleView.titleViewHeight(title: self.alertTitle,
                    message: self.alertMessage,
                    width: HYConstants.ScreenWidth)
            }
            let newTableFrame: CGRect = CGRect(x: 0,
                y: HYConstants.ScreenHeight - tableHeight,
                width: HYConstants.ScreenWidth,
                height: tableHeight)
            self.alertHeight = tableHeight
            self.sheetView.sheetTitle = self.alertTitle
            self.sheetView.sheetMessage = self.alertMessage
            self.sheetView.frame = newTableFrame
        } else {
            var tableHeight: CGFloat = HYAlertCell.cellHeight * CGFloat(self.actionArray.count) + HYAlertCell.cellHeight + 10
            if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
                tableHeight += HYTitleView.titleViewHeight(title: self.alertTitle,
                    message: self.alertMessage,
                    width: HYConstants.ScreenWidth - HYConstants.alertSpec)
            }
            let newTableFrame: CGRect = CGRect(x: 0,
                y: 0,
                width: HYConstants.ScreenWidth - HYConstants.alertSpec,
                height: tableHeight)
            self.alertHeight = tableHeight
            self.alertView.alertTitle = self.alertTitle
            self.alertView.alertMessage = self.alertMessage
            self.alertView.frame = newTableFrame
            self.alertView.center = self.view.center
        }
    }

    fileprivate func initUI() {
        self.view.addSubview(self.dimBackgroundView)
        switch self.alertStyle {
        case .actionSheet:
            self.sheetView.delegate = self
            self.view.addSubview(self.sheetView)
            break

        case .shareSheet:
            self.shareView.delegate = self
            self.view.addSubview(self.shareView)
            break

        case .alert:
            self.alertView.delegate = self
            self.view.addSubview(self.alertView)
            break
        }
    }
}

// MARK: - Public Methods
extension HYAlertController {
    open func addAction(action: HYAlertAction) {
        if action.style == .cancel {
            cancelActionArray.append(action)
        } else {
            actionArray.append([action])
        }
        if self.alertStyle == .actionSheet {
            sheetView.refreshDate(dataArray: actionArray[0], cancelArray: cancelActionArray, title: alertTitle, message: alertMessage)
        } else if self.alertStyle == .alert {
            alertView.refreshDate(dataArray: actionArray[0], cancelArray: self.cancelActionArray, title: alertTitle, message: alertMessage)
        } else {
        }
    }

    /// 添加必须是元素为HYAlertAction的数组，调用几次该方法，分享显示几行
    open func addShareActions(actions: [HYAlertAction]) {
        actionArray += [actions]
        shareView.refreshDate(dataArray: actionArray, cancelArray: cancelActionArray, title: alertTitle, message: alertMessage)
    }
}

// MARK: - HYActionSheetViewDelegate
extension HYAlertController: HYActionSheetViewDelegate {
    func clickSheetItemHandler() {
        dismiss()
    }
}

// MARK: - HYShareViewDelegate
extension HYAlertController: HYShareViewDelegate {
    func clickedShareItemHandler() {
        dismiss()
    }
}

// MARK: - HYAlertViewDelegate
extension HYAlertController: HYAlertViewDelegate {
    func clickAlertItemHandler() {
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
        cancelActionArray.removeAll()

        dismiss(animated: true, completion: nil)
    }
}
