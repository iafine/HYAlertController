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
        return HY_Constants.presentAnimateDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC: HYAlertController = transitionContext.viewController(forKey: .to) as! HYAlertController
        let fromVC: UIViewController = transitionContext.viewController(forKey: .from)!
        let containerView: UIView = transitionContext.containerView
        
        // start animation status
        toVC.dimBackgroundView.alpha = 0
        if toVC.alertStyle == .actionSheet {
            toVC.sheetView.frame = CGRect (x: fromVC.view.frame.origin.x,
                                           y: fromVC.view.frame.size.height,
                                           width: fromVC.view.frame.size.width,
                                           height: fromVC.view.frame.size.height)
        }else if toVC.alertStyle == .shareSheet {
            toVC.shareView.frame = CGRect (x: fromVC.view.frame.origin.x,
                                           y: fromVC.view.frame.size.height,
                                           width: fromVC.view.frame.size.width,
                                           height: fromVC.view.frame.size.height)
        }else {
            toVC.view.alpha = 0
        }
        containerView.addSubview(toVC.view)
        
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        
        // 执行动画
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            toVC.dimBackgroundView.alpha = 1
            if toVC.alertStyle == .actionSheet {
                toVC.sheetView.frame = transitionContext.finalFrame(for: toVC)
            }else if toVC.alertStyle == .shareSheet {
                toVC.shareView.frame = transitionContext.finalFrame(for: toVC)
            }else {
                toVC.view.alpha = 1
            }
        }, completion: { (finished) in
            transitionContext.completeTransition(true)
        })
    }
}
