//
//  UIViewController+Common.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/15.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *splitVc = (UISplitViewController *)vc;
        if (splitVc.viewControllers.count > 0) {
            return [self findBestViewController:splitVc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        if (nav.viewControllers.count > 0) {
            return [self findBestViewController:nav.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if (tab.viewControllers.count > 0) {
            return [self findBestViewController:tab.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+ (UIViewController *)currentViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:vc];
}

@end
