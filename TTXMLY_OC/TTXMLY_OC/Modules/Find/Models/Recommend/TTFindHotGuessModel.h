//
//  TTFindHotGuessModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseModel.h"
#import "TTFindRecommendModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TTFindDiscoverColumnsModel, TTFindGuessULikeModel, TTCityColumnModel, TTFindHotRecommendModel;

/// 热门推荐、猜你
@interface TTFindHotGuessModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) TTFindDiscoverColumnsModel *discoveryColumns;

@property (nonatomic, strong) TTFindGuessULikeModel *guess;

@property (nonatomic, strong) TTCityColumnModel *cityColumn;

@property (nonatomic, strong) TTFindHotRecommendModel *hotRecommends;

@end

#pragma mark - 发现新奇

@class TTFindDiscoverDetailModel, TTFindDiscoverProperityModel;

@interface TTFindDiscoverColumnsModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray<TTFindDiscoverDetailModel *> *list;

@end

@interface TTFindDiscoverDetailModel : TTBaseModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *coverPath;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *sharePic;

@property (nonatomic, assign) BOOL enableShare;

@property (nonatomic, assign) BOOL isExternalUrl;

@property (nonatomic, strong) TTFindDiscoverProperityModel *properties;

@end

@interface TTFindDiscoverProperityModel : TTBaseModel

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, assign) NSInteger rankingListId;

@property (nonatomic, assign) BOOL isPaid;

@property (nonatomic, copy) NSString *key;

@end

#pragma mark - 猜你喜欢

@interface TTFindGuessULikeModel : TTBaseModel

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *list;

@end

#pragma mark - 城市专题

@interface TTCityColumnModel : TTBaseModel

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray<TTFindEditorRecommendDetailModel *> *list;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, copy) NSString *code;

@end

#pragma mark - 热门推荐

@class TTFindHotRecommendItemModel;

@interface TTFindHotRecommendModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray<TTFindHotRecommendItemModel *> *list;

@end

@interface TTFindHotRecommendItemModel : TTBaseModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, assign) BOOL isFinished;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger categoryType;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, strong) NSMutableArray<TTFindEditorRecommendDetailModel *> *list;

@property (nonatomic, assign) BOOL filterSupported;

@property (nonatomic, assign) BOOL isPaid;

@end

NS_ASSUME_NONNULL_END
