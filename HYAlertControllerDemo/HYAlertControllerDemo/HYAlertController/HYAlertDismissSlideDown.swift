//
//  HYAlertDismissSlideDown.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertDismissSlideDown: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return HY_Constants.dismissAnimateDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC: HYAlertController = transitionContext.viewController(forKey: .from) as! HYAlertController
        
        // start animation status
        fromVC.dimBackgroundView.alpha = 1
        
        if fromVC.alertStyle == .alert {
            fromVC.view.alpha = 1
        }
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        let finalY: CGFloat = fromVC.view.frame.size.height
        
        // 执行动画
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            fromVC.dimBackgroundView.alpha = 0
            if fromVC.alertStyle == .actionSheet {
                fromVC.sheetView.frame.origin.y += finalY
            }else if fromVC.alertStyle == .shareSheet {
                fromVC.shareView.frame.origin.y += finalY
            }else {
                fromVC.view.alpha = 0
            }
        }, completion: { (finished) in
            transitionContext.completeTransition(true)
        })
    }
}

