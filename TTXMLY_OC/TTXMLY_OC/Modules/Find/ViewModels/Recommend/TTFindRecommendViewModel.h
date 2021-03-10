//
//  TTFindRecommendViewModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseViewModel.h"

@class TTFindRecommendModel, TTFindLiveModel, TTFindHotGuessModel;

typedef NS_ENUM(NSInteger, TTFindRecommendSection) {
    TTFindRecommendSection_Recommend  = 0, // 小编推荐
    TTFindRecommendSection_Live       = 1, // 直播
    TTFindRecommendSection_GuessULike = 2, // 猜你喜欢
    TTFindRecommendSection_CityColumn = 3, // 城市歌单
    TTFindRecommendSection_Special    = 4, // 精品听单
    TTFindRecommendSection_Advertise  = 5, // 广告推广
    TTFindRecommendSection_Hot        = 6, // 热门推荐
    TTFindRecommendSection_More       = 7, // 更多
};

#define kFindRecommendUpdateSignalName @"TTFindRecomViewModelUpdateContentSignal"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindRecommendViewModel : TTBaseViewModel

/// 直播数据动态
@property (nonatomic, strong) TTFindLiveModel *liveModel;

/// 推荐数据动态
@property (nonatomic, strong) TTFindRecommendModel *recommendModel;

/// 热门、猜你数据动态
@property (nonatomic, strong) TTFindHotGuessModel *hotGuessModel;

@end

NS_ASSUME_NONNULL_END
