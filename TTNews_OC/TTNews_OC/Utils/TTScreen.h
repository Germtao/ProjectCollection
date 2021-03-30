//
//  TTScreen.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 是否横屏
#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))

#define SCREEN_WIDTH  (IS_LANDSCAPE ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

#define IS_SPECIAL_SCREEN (SCREEN_HEIGHT >= 812 && ([UIScreen mainScreen].scale == 2 || [UIScreen mainScreen].scale == 3))

#define STATUS_BAR_HEIGHT (IS_SPECIAL_SCREEN ? 44 : 20)
#define TOP_BAR_HEIGHT    (IS_SPECIAL_SCREEN ? 88 : 64)

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

static inline NSInteger UIAdapter (float f) {
    // 1 - 分机型 特定的比例
    
    // 2 - 屏幕宽度按比例适配
    CGFloat scale = 414 / SCREEN_WIDTH;
    return (NSInteger)f / scale;
}

#pragma mark - ...完善其他方法..size..rect..origin..

static inline CGRect UIRectAdapter (x, y, width, height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface TTScreen : NSObject

@end

NS_ASSUME_NONNULL_END
