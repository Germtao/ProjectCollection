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

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)

#define IS_IPHONE_X (SCREEN_WIDTH == [TTScreen sizeFor58Inch].width && SCREEN_HEIGHT == [TTScreen sizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [TTScreen sizeFor61Inch].width && SCREEN_HEIGHT == [TTScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [TTScreen sizeFor65Inch].width && SCREEN_HEIGHT == [TTScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define STATUS_BAR_HEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

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

/// iPhone xs max、12pro max
+ (CGSize)sizeFor65Inch;

/// iPhone xr、12、12pro
+ (CGSize)sizeFor61Inch;

/// iPhone x
+ (CGSize)sizeFor58Inch;

#pragma mark - TODO: 其他机型

@end

NS_ASSUME_NONNULL_END
