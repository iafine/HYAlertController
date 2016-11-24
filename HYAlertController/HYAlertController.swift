//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYAlertControllerStyle : Int {
    
    case actionSheet
    
    case shareSheet
    
    case alert
}

// MARK: - Class
class HYAlertController: UIViewController {

    var alertTitle: String
    var alertMessage: String
    var alertStyle: HYAlertControllerStyle
    
    fileprivate var actionArray: NSMutableArray = NSMutableArray ()
    fileprivate var cancelActionArray: NSMutableArray = NSMutableArray ()
    
    var alertHeight: CGFloat = CGFloat()

    lazy var shareView: HYShareView = {
        let view: HYShareView = HYShareView (frame: CGRect.zero)
        return view
    }()
    
    lazy var sheetView: HYActionSheetView = {
        let view: HYActionSheetView = HYActionSheetView (frame: CGRect.zero)
        return view
    }()
    
    lazy var alertView: HYAlertView = {
        let view: HYAlertView = HYAlertView (frame: CGRect.zero)
        return view
    }()
    
    lazy var dimBackgroundView: UIView = {
        let view: UIView = UIView (frame: CGRect (x: 0,
                                                  y: 0,
                                                  width: HY_Constants.ScreenWidth,
                                                  height: HY_Constants.ScreenHeight))
        view.backgroundColor = UIColor (white: 0, alpha: HY_Constants.dimBackgroundAlpha)
        view.alpha = 0
        
        // 添加手势监听
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector (clickedBgViewHandler))
        view.addGestureRecognizer(tapGR)
        return view
    }()
    
    init(title: String?, message: String?, style: HYAlertControllerStyle) {
        self.alertTitle = (title ?? "").isEmpty ? "" : title!
        self.alertMessage = (message ?? "").isEmpty ? "" : message!
        self.alertStyle = style
        super.init(nibName: nil, bundle: nil)
        
        // 自定义转场动画
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear

        initUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.alertStyle == .shareSheet {
            var tableHeight: CGFloat = HYShareTableViewCell.cellHeight() * CGFloat (self.actionArray.count) + 44
            if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
                tableHeight += HYTitleView.titleViewHeight(title: self.alertTitle,
                                                           message: self.alertMessage,
                                                           width: HY_Constants.ScreenWidth)
            }
            let newTableFrame: CGRect = CGRect (x: 0,
                                                y: HY_Constants.ScreenHeight - tableHeight,
                                                width: HY_Constants.ScreenWidth,
                                                height: tableHeight)
            self.alertHeight = tableHeight
            self.shareView.shareTitle = self.alertTitle
            self.shareView.shareMessage = self.alertMessage
            self.shareView.frame = newTableFrame
        }else if self.alertStyle == .actionSheet {
            var tableHeight: CGFloat = HYAlertCell.cellHeight() * CGFloat (self.actionArray.count) + HYAlertCell.cellHeight() + 10
            if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
                tableHeight += HYTitleView.titleViewHeight(title: self.alertTitle,
                                                           message: self.alertMessage,
                                                           width: HY_Constants.ScreenWidth)
            }
            let newTableFrame: CGRect = CGRect (x: 0,
                                                y: HY_Constants.ScreenHeight - tableHeight,
                                                width: HY_Constants.ScreenWidth,
                                                height: tableHeight)
            self.alertHeight = tableHeight
            self.sheetView.sheetTitle = self.alertTitle
            self.sheetView.sheetMessage = self.alertMessage
            self.sheetView.frame = newTableFrame
        }else {
            var tableHeight: CGFloat = HYAlertCell.cellHeight() * CGFloat (self.actionArray.count) + HYAlertCell.cellHeight() + 10
            if self.alertTitle.characters.count > 0 || self.alertMessage.characters.count > 0 {
                tableHeight += HYTitleView.titleViewHeight(title: self.alertTitle,
                                                           message: self.alertMessage,
                                                           width: HY_Constants.ScreenWidth - HY_Constants.alertSpec)
            }
            let newTableFrame: CGRect = CGRect (x: 0,
                                                y: 0,
                                                width: HY_Constants.ScreenWidth - HY_Constants.alertSpec,
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
            self.cancelActionArray.add(action)
        }else {
            self.actionArray.add(action)
        }
        if self.alertStyle == .actionSheet {
            self.sheetView.refreshDate(dataArray: self.actionArray, cancelArray: self.cancelActionArray, title: self.alertTitle, message: self.alertMessage)
        }else if self.alertStyle == .alert {
            self.alertView.refreshDate(dataArray: self.actionArray, cancelArray: self.cancelActionArray, title: self.alertTitle, message: self.alertMessage)
        }else {
        }
    }
    
    /// 添加必须是元素为HYAlertAction的数组，调用几次该方法，分享显示几行
    open func addShareActions(actions: Array<HYAlertAction>) {
        self.actionArray.add(actions)
        self.shareView.refreshDate(dataArray: self.actionArray, cancelArray: self.cancelActionArray, title: self.alertTitle, message: self.alertMessage)
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
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertPresentSlideUp ()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertDismissSlideDown ()
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
        self.actionArray.removeAllObjects()
        self.cancelActionArray.removeAllObjects()
        
        self.dismiss(animated: true, completion: nil)
    }
}

