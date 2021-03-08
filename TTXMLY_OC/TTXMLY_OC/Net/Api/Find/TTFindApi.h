//
//  TTFindApi.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "TTBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindApi : TTBaseApi

/// 请求小编推荐数据、精品歌单
+ (void)requestRecommends:(TTBaseApiCompletion)completion;

/// 请求发现新奇、猜你喜欢等数据
+ (void)requestHotAndGuess:(TTBaseApiCompletion)completion;

/// 请求正在直播等数据
+ (void)requestLiveRecommend:(TTBaseApiCompletion)completion;

/// 请求推荐中的 ad
+ (void)requestFooterAd:(TTBaseApiCompletion)completion;

@end

NS_ASSUME_NONNULL_END
