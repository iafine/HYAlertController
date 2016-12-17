//
//  HYAlertPresentSlideUp.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertPresentSlideUp: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return HYConstants.presentAnimateDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? HYAlertController else { return }
        let fromVC = transitionContext.viewController(forKey: .from)!
        let containerView = transitionContext.containerView

        // start animation status
        toVC.dimBackgroundView.alpha = 0
        if toVC.alertStyle == .actionSheet {
            toVC.pickerView.frame = CGRect(x: fromVC.view.frame.minX,
                y: fromVC.view.frame.height,
                width: fromVC.view.frame.width,
                height: fromVC.view.frame.height)
        } else if toVC.alertStyle == .shareSheet {
            toVC.pickerView.frame = CGRect(x: fromVC.view.frame.minX,
                y: fromVC.view.frame.height,
                width: fromVC.view.frame.width,
                height: fromVC.view.frame.height)
        } else {
            toVC.view.alpha = 0
        }
        containerView.addSubview(toVC.view)

        let duration = transitionDuration(using: transitionContext)

        // 执行动画
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            toVC.dimBackgroundView.alpha = 1
            if [.actionSheet, .shareSheet].contains(toVC.alertStyle) {
                toVC.pickerView.frame = transitionContext.finalFrame(for: toVC)
            } else {
                toVC.view.alpha = 1
            }
        }, completion: { (finished) in
            transitionContext.completeTransition(true)
        })
    }
}
