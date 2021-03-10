//
//  TTFindRecommendHelper.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import <Foundation/Foundation.h>

#define kNotificationFindRecommendHeaderTimer  @"kNotificationFindRecommendHeaderTimer"
#define kNotificationFindRecommendLiveTimer    @"kNotificationFindRecommendLiveTimer"

typedef NS_ENUM(NSInteger, TTFindRecommendTimer) {
    TTFindRecommendTimer_Banner = 0, // 轮播
    TTFindRecommendTimer_Live   = 1, // 直播
};

NS_ASSUME_NONNULL_BEGIN

@interface TTFindRecommendHelper : NSObject

+ (instancetype)sharedInstance;

- (void)startTimer:(TTFindRecommendTimer)style;

- (void)stopTimer:(TTFindRecommendTimer)style;

- (void)stopAllTimer;

@end

NS_ASSUME_NONNULL_END
