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
        return HYConstants.dismissAnimateDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? HYAlertController else {
            return
        }

        // start animation status
        fromVC.dimBackgroundView.alpha = 1
        let isSheet = [.shareSheet, .actionSheet].contains(fromVC.alertStyle)
        var finalY: CGFloat = 0.0
        if isSheet {
            finalY = fromVC.view.frame.height
        }else {
            fromVC.pickerView.transform = CGAffineTransform (scaleX: 1, y: 1)
        }
        
        let duration = transitionDuration(using: transitionContext)
        // 执行动画
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            fromVC.dimBackgroundView.alpha = 0
            if isSheet {
                fromVC.pickerView.frame.origin.y += finalY
            } else {
                fromVC.pickerView.transform = CGAffineTransform (scaleX: 0, y: 0)
            }
        }, completion: { (finished) in
            transitionContext.completeTransition(true)
        })
    }
}
