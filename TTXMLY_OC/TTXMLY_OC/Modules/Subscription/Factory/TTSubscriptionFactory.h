//
//  TTSubscriptionFactory.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTSubscriptionStyle) {
    TTSubscriptionStyle_Subscription = 0, // 订阅听
    TTSubscriptionStyle_Download     = 1, // 下载听
};

NS_ASSUME_NONNULL_BEGIN

@interface TTSubscriptionFactory : NSObject

+ (NSArray *)subControllersWithStyle:(TTSubscriptionStyle)style;

+ (NSArray *)subTitlesWithStyle:(TTSubscriptionStyle)style;

@end

NS_ASSUME_NONNULL_END
