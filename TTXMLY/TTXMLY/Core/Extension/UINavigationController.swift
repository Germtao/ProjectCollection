//
//  UINavigationController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 处理返回手势
extension UINavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if let topVc = topViewController,
            let coor = topVc.transitionCoordinator,
            coor.initiallyInteractive {
            if #available(iOS 10.0, *) {
                coor.notifyWhenInteractionChanges { (context) in
                    self.dealInteractionChanges(context)
                }
            } else {
                coor.notifyWhenInteractionEnds { (context) in
                    self.dealInteractionChanges(context)
                }
            }
            return true
        }
        
        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVc = viewControllers[viewControllers.count - n]
        
        popToViewController(popToVc, animated: true)
        return true
    }
    
    /// 处理返回中断的手势
    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        let animations: (UITransitionContextViewControllerKey) -> Void = {
            let currentColor = context.viewController(forKey: $0)?.navBarBarTintColor ?? TTNavigationBar.defaultBarTintColor
            let currentAlpha = context.viewController(forKey: $0)?.navBarBackgroundAlpha ?? TTNavigationBar.defaultBackgroundAlpha
            
            self.setNeedsNavigationBarUpdate(barTintColor: currentColor)
            self.setNeedsNavigationBarUpdate(barBackgroundAlpha: currentAlpha)
        }
        
        if context.isCancelled {
            let cancelDuration: TimeInterval = context.transitionDuration * Double(context.percentComplete)
            UIView.animate(withDuration: cancelDuration) {
                animations(.from)
            }
        } else {
            let finishDuration: TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration) {
                animations(.to)
            }
        }
    }
    
    @objc func tt_updateInteractiveTransition(_ percentComplete: CGFloat) {
        guard let topVc = topViewController,
            let coor = topVc.transitionCoordinator else {
            tt_updateInteractiveTransition(percentComplete)
            return
        }
        
        let fromVc = coor.viewController(forKey: .from)
        let toVc = coor.viewController(forKey: .to)
        updateNavigationBar(from: fromVc, to: toVc, progress: percentComplete)
        tt_updateInteractiveTransition(percentComplete)
    }
}

extension UINavigationController: TTFatherAwakeProtocol {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.statusBarStyle ?? TTNavigationBar.defaultStatusBarStyle
    }
    
    func setNeedsNavigationBarUpdate(backgroundImage: UIImage) {
        navigationBar.tt_setBackgroundImage(image: backgroundImage)
    }
    
    func setNeedsNavigationBarUpdate(barTintColor: UIColor) {
        navigationBar.tt_setBackgroundColor(color: barTintColor)
    }
    
    func setNeedsNavigationBarUpdate(barBackgroundAlpha: CGFloat) {
        navigationBar.tt_setBackgroundAlpha(alpha: barBackgroundAlpha)
    }
    
    func setNeedsNavigationBarUpdate(tintColor: UIColor) {
        navigationBar.tintColor = tintColor
    }
    
    func setNeedsNavigationBarUpdate(hideShadowImage: Bool) {
        navigationBar.shadowImage = hideShadowImage ? UIImage() : nil
    }
    
    func setNeedsNavigationBarUpdate(titleColor: UIColor) {
        guard let attributes = navigationBar.titleTextAttributes else {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            return
        }
        
        var newAttributes = attributes
        newAttributes.updateValue(titleColor, forKey: NSAttributedString.Key.foregroundColor)
        navigationBar.titleTextAttributes = newAttributes
    }
    
    private func updateNavigationBar(from fromVc: UIViewController?, to toVc: UIViewController?, progress: CGFloat) {
        let fromBarTintColor = fromVc?.navBarBarTintColor ?? TTNavigationBar.defaultBarTintColor
        let toBarTintColor = toVc?.navBarBarTintColor ?? TTNavigationBar.defaultBarTintColor
        let newBarTintColor = TTNavigationBar.middleColor(from: fromBarTintColor, to: toBarTintColor, percent: progress)
        setNeedsNavigationBarUpdate(barTintColor: newBarTintColor)
        
        let fromTintColor = fromVc?.navBarTintColor ?? TTNavigationBar.defaultTintColor
        let toTintColor = toVc?.navBarTintColor ?? TTNavigationBar.defaultTintColor
        let newTintColor = TTNavigationBar.middleColor(from: fromTintColor, to: toTintColor, percent: progress)
        setNeedsNavigationBarUpdate(tintColor: newTintColor)
        
        let fromTitleColor = fromVc?.navBarTitleColor ?? TTNavigationBar.defaultBarTitleColor
        let toTitleColor = toVc?.navBarTitleColor ?? TTNavigationBar.defaultBarTitleColor
        let newTitleColor = TTNavigationBar.middleColor(from: fromTitleColor, to: toTitleColor, percent: progress)
        setNeedsNavigationBarUpdate(titleColor: newTitleColor)
        
        let fromAlpha = fromVc?.navBarBackgroundAlpha ?? TTNavigationBar.defaultBackgroundAlpha
        let toAlpha = toVc?.navBarBackgroundAlpha ?? TTNavigationBar.defaultBackgroundAlpha
        let newAlpha = TTNavigationBar.middleAlpha(from: fromAlpha, to: toAlpha, percent: progress)
        setNeedsNavigationBarUpdate(barBackgroundAlpha: newAlpha)
    }
    
    private static let onceToken = UUID().uuidString
    static func fatherAwake() {
        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectors = [
                NSSelectorFromString("_updateInteractiveTransition:"),
                #selector(popToViewController),
                #selector(popToRootViewController),
                #selector(pushViewController)
            ]
            
            for selector in needSwizzleSelectors {
                let str = ("tt_" + selector.description).replacingOccurrences(of: "__", with: "_")
                if let originMethod = class_getInstanceMethod(self, selector),
                    let swizzleMethod = class_getInstanceMethod(self, Selector(str)) {
                    method_exchangeImplementations(originMethod, swizzleMethod)
                }
            }
        }
    }
    
    // MARK: - swizzling pop & push
    struct Properties {
        static let duration = 0.13
        static var displayCount = 0
        static var progress: CGFloat {
            let all: CGFloat = CGFloat(60 * duration)
            let current = min(all, CGFloat(displayCount))
            return current / all
        }
    }
    
    @objc func tt_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBarUpdate(titleColor: viewController.navBarTitleColor)
        var displayLink: CADisplayLink? = CADisplayLink(target: self, selector: #selector(needDisplay))
        // UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
        displayLink?.add(to: RunLoop.current, forMode: .common)
        
        CATransaction.setCompletionBlock {
            displayLink?.invalidate()
            displayLink = nil
            Properties.displayCount = 0
        }
        CATransaction.setAnimationDuration(Properties.duration)
        CATransaction.begin()
        let vcs = tt_popToViewController(viewController, animated: true)
        CATransaction.commit()
        return vcs
    }
    
    @objc func tt_popToRootViewController(animated: Bool) -> [UIViewController]? {
        var displayLink: CADisplayLink? = CADisplayLink(target: self, selector: #selector(needDisplay))
        displayLink?.add(to: RunLoop.current, forMode: .common)
        
        CATransaction.setCompletionBlock {
            displayLink?.invalidate()
            displayLink = nil
            Properties.displayCount = 0
        }
        CATransaction.setAnimationDuration(Properties.duration)
        CATransaction.begin()
        let vcs = tt_popToRootViewController(animated: animated)
        CATransaction.commit()
        return vcs
    }
    
    @objc func tt_pushViewController(_ viewController: UIViewController, animated: Bool) {
        var displayLink: CADisplayLink? = CADisplayLink(target: self, selector: #selector(needDisplay))
        displayLink?.add(to: .current, forMode: .common)
        
        CATransaction.setCompletionBlock {
            displayLink?.invalidate()
            displayLink = nil
            Properties.displayCount = 0
            viewController.pushToCurrentVcFinished = true
        }
        CATransaction.setAnimationDuration(Properties.duration)
        CATransaction.begin()
        tt_pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    @objc private func needDisplay() {
        guard let topVc = topViewController,
            let coor = topVc.transitionCoordinator else { return }
        
        Properties.displayCount += 1
        let progress = Properties.progress
        let fromVc = coor.viewController(forKey: .from)
        let toVc = coor.viewController(forKey: .to)
        updateNavigationBar(from: fromVc, to: toVc, progress: progress)
    }
}
