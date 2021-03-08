//
//  TTFindApi.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTFindApi.h"

#define kRecommendAPI     @"http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.21"

#define kHotAndGuessAPI   @"http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.21"

#define kLiveRecommendAPI @"http://live.ximalaya.com/live-activity-web/v3/activity/recommend"

#define kRecomBannerAPI   @"http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.21"

@implementation TTFindApi

+ (void)requestRecommends:(TTBaseApiCompletion)completion {
    TTBaseRequest *request = [TTBaseRequest requestWithURL:kRecommendAPI];
    [request startWithMethod:TTHttpType_GET params:nil completion:^(id  _Nullable responseObject, NSString * _Nullable message, BOOL success) {
        if (completion) {
            completion(responseObject, message, success);
        }
    }];
}

+ (void)requestHotAndGuess:(TTBaseApiCompletion)completion {
    TTBaseRequest *request = [TTBaseRequest requestWithURL:kHotAndGuessAPI];
    [request startWithMethod:TTHttpType_GET params:nil completion:^(id  _Nullable responseObject, NSString * _Nullable message, BOOL success) {
        if (completion) {
            completion(responseObject, message, success);
        }
    }];
}

+ (void)requestLiveRecommend:(TTBaseApiCompletion)completion {
    TTBaseRequest *request = [TTBaseRequest requestWithURL:kLiveRecommendAPI];
    [request startWithMethod:TTHttpType_GET params:nil completion:^(id  _Nullable responseObject, NSString * _Nullable message, BOOL success) {
        if (completion) {
            completion(responseObject, message, success);
        }
    }];
}

+ (void)requestFooterAd:(TTBaseApiCompletion)completion {
    TTBaseRequest *request = [TTBaseRequest requestWithURL:kRecomBannerAPI];
    [request startWithMethod:TTHttpType_GET params:nil completion:^(id  _Nullable responseObject, NSString * _Nullable message, BOOL success) {
        if (completion) {
            completion(responseObject, message, success);
        }
    }];
}

@end
