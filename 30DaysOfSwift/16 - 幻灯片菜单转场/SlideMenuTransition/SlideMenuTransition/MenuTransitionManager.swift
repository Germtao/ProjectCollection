//
//  MenuTransitionManager.swift
//  SlideMenuTransition
//
//  Created by TT on 2020/5/10.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

enum MenuTransitionType {
    case left
    case up
}

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class MenuTransitionManager: NSObject {
    
    var duration = 0.5
    var isPresenting = false
    var delegate: MenuTransitionManagerDelegate?
    var type: MenuTransitionType = .left
    
    var snapShot: UIView? {
        didSet {
            if let _delegate = delegate {
                let tap = UITapGestureRecognizer(target: _delegate, action: #selector(_delegate.dismiss))
                snapShot?.addGestureRecognizer(tap)
            }
        }
    }
}

extension MenuTransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from)?.view else { return }
        guard let to = transitionContext.viewController(forKey: .to)?.view else { return }
        let container = transitionContext.containerView
        
        if isPresenting {
            snapShot = from.snapshotView(afterScreenUpdates: true)
            container.addSubview(to)
            if let _snapShot = snapShot {
                container.addSubview(_snapShot)
            }
        }
        
        switch type {
        case .left:
            let moveLeft = CGAffineTransform(translationX: 250, y: 0)
            let moveRight = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                
                if self.isPresenting {
                    self.snapShot?.transform = moveLeft
                    to.transform = .identity
                } else {
                    self.snapShot?.transform = .identity
                    to.transform = moveRight
                }
                
            }) { _ in
                transitionContext.completeTransition(true)
                if !self.isPresenting {
                    self.snapShot?.removeFromSuperview()
                }
            }
            
        case .up:
            let frame = container.frame
            let moveDown = CGAffineTransform(translationX: 0, y: frame.height - 300)
            let moveUp = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                
                if self.isPresenting {
                    self.snapShot?.transform = moveDown
                    to.transform = .identity
                } else {
                    self.snapShot?.transform = .identity
                    to.transform = moveUp
                }
                
            }) { _ in
                transitionContext.completeTransition(true)
                if !self.isPresenting {
                    self.snapShot?.removeFromSuperview()
                }
            }
        }
        
        
    }
}

extension MenuTransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
}
