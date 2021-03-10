//
//  TTFindRecommendHelper.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindRecommendHelper.h"

@interface TTFindRecommendHelper ()

@property (nonatomic, strong) NSTimer *findRecommendBannerTimer;

@property (nonatomic, strong) NSTimer *findRecommendLiveTimer;

@end

@implementation TTFindRecommendHelper

+ (instancetype)sharedInstance {
    static TTFindRecommendHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TTFindRecommendHelper alloc] init];
    });
    return helper;
}

- (void)startTimer:(TTFindRecommendTimer)style {
    [self stopTimer:style];
    
    switch (style) {
        case TTFindRecommendTimer_Banner:
            _findRecommendBannerTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(bannerTimerChanged) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_findRecommendBannerTimer forMode:NSRunLoopCommonModes];
            break;
            
        case TTFindRecommendTimer_Live:
            _findRecommendLiveTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(liveTimerChanged) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_findRecommendLiveTimer forMode:NSRunLoopCommonModes];
            break;
    }
}

- (void)stopTimer:(TTFindRecommendTimer)style {
    switch (style) {
        case TTFindRecommendTimer_Banner:
            if (_findRecommendBannerTimer) {
                [_findRecommendBannerTimer setFireDate:[NSDate distantFuture]];
                [_findRecommendBannerTimer invalidate];
                _findRecommendBannerTimer = nil;
            }
            break;
            
        case TTFindRecommendTimer_Live:
            if (_findRecommendLiveTimer) {
                [_findRecommendLiveTimer setFireDate:[NSDate distantFuture]];
                [_findRecommendLiveTimer invalidate];
                _findRecommendLiveTimer = nil;
            }
            break;
    }
}

- (void)stopAllTimer {
    [self stopTimer:TTFindRecommendTimer_Banner];
    [self stopTimer:TTFindRecommendTimer_Live];
}

#pragma mark - Action

- (void)bannerTimerChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFindRecommendHeaderTimer object:nil];
}

- (void)liveTimerChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFindRecommendLiveTimer object:nil];
}

@end
