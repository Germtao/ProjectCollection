//
//  TransitionManger.swift
//  TumblrMenu
//
//  Created by TT on 2020/5/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class TransitionManger: NSObject {
    
    private var isPresenting = false
    
    func offstage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuVc: MenuViewController) {
        menuVc.view.alpha = 0
        
        let topRowOffset: CGFloat = 300
        let centerRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menuVc.textBtn.transform = offstage(-topRowOffset)
        menuVc.photoBtn.transform = offstage(topRowOffset)
        
        menuVc.quoteBtn.transform = offstage(-centerRowOffset)
        menuVc.linkBtn.transform = offstage(centerRowOffset)
        
        menuVc.chatBtn.transform = offstage(-bottomRowOffset)
        menuVc.audioBtn.transform = offstage(bottomRowOffset)
    }
    
    func onStageMenuController(_ menuVc: MenuViewController) {
        menuVc.view.alpha = 1
        
        menuVc.textBtn.transform = .identity
        menuVc.photoBtn.transform = .identity
        
        menuVc.quoteBtn.transform = .identity
        menuVc.linkBtn.transform = .identity
        
        menuVc.chatBtn.transform = .identity
        menuVc.audioBtn.transform = .identity
    }

}

extension TransitionManger: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

extension TransitionManger: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to) else { return }
        
        // 创建屏幕 元组
        let screens: (from: UIViewController, to: UIViewController) = (from, to)
        
        // 从元组向我们的菜单视图控制器和“底部”视图控制器分配引用
        // 请记住，我们的menuVc将在from和to控制器之间切换，这取决于我们是显示还是关闭
        let menuVc = !isPresenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomVc = !isPresenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView: UIView! = menuVc.view
        let bottomView: UIView! = bottomVc.view
        
        // 准备菜单
        if isPresenting {
            offStageMenuController(menuVc)
        }
        
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                self.onStageMenuController(menuVc)
            } else {
                self.offStageMenuController(menuVc)
            }
        }) { _ in
            transitionContext.completeTransition(true)
//            UIApplication.shared.windows.last?.addSubview(screens.to.view)
        }
    }
    
    
}
