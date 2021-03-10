//
//  TTFindRecommendModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseModel.h"

@class TTFindEditorRecommendAlbumModel, TTFindEditorRecommendDetailModel,
TTFindSpecialColumnModel, TTFindSpecialColumnDetailModel,
TTFindFocusImagesModel, TTFindFocusImageDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface TTFindRecommendModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) TTFindEditorRecommendAlbumModel *editorRecommendAlbums;

@property (nonatomic, strong) TTFindSpecialColumnModel *specialColumn;

@property (nonatomic, strong) TTFindFocusImagesModel *focusImages;

@property (nonatomic, copy) NSString *msg;

@end

/// 小编推荐专辑
@interface TTFindEditorRecommendAlbumModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

/// 标题
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *msg;

/// 是否有更多
@property (nonatomic, assign) BOOL hasMore;

/// 小编推荐详情 list
@property (nonatomic, strong) NSMutableArray<TTFindEditorRecommendDetailModel *> *list;

@end

/// 精品听单
@interface TTFindSpecialColumnModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, strong) NSMutableArray<TTFindSpecialColumnDetailModel *> *list;

@end

/// 轮播图
@interface TTFindFocusImagesModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *list;

@end

/// 小编推荐详情
@interface TTFindEditorRecommendDetailModel : TTBaseModel

/// 唯一标识
@property (nonatomic, assign) NSInteger cid;

/// 专辑标识
@property (nonatomic, assign) NSInteger albumId;

/// 用户标识
@property (nonatomic, assign) NSInteger uid;

/// 介绍
@property (nonatomic, copy) NSString *intro;

/// 昵称
@property (nonatomic, copy) NSString *nickname;

/// 专辑封面290像素 url
@property (nonatomic, copy) NSString *albumCoverUrl290;

/// 小封面
@property (nonatomic, copy) NSString *coverSmall;

/// 中封面
@property (nonatomic, copy) NSString *coverMiddle;

/// 大封面
@property (nonatomic, copy) NSString *coverLarge;

/// 标题
@property (nonatomic, copy) NSString *title;

/// 标记
@property (nonatomic, copy) NSString *tags;

@property (nonatomic, assign) NSInteger tracks;

/// 播放量
@property (nonatomic, assign) NSInteger  playsCounts;

@property (nonatomic, assign) NSInteger  isFinished;

@property (nonatomic, assign) NSInteger  serialState;

@property (nonatomic, assign) NSInteger  trackId;

@property (nonatomic, copy) NSString *trackTitle;

/// 是否支付过
@property (nonatomic, assign) BOOL isPaid;

/// 评论数量
@property (nonatomic, assign) NSInteger commentsCount;

@property (nonatomic, assign) NSInteger priceTypeId;
@property (nonatomic, assign) NSInteger priceTypeEnum;

@end

/// 精品听单详情
@interface TTFindSpecialColumnDetailModel : TTBaseModel

@property (nonatomic, assign) NSInteger columnType;

@property (nonatomic, assign) NSInteger specialId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *footnote;

@property (nonatomic, copy) NSString *coverPath;

@property (nonatomic, assign) NSInteger contentType;

@end

/// 轮播图详情
@interface TTFindFocusImageDetailModel : TTBaseModel

@property (nonatomic, assign) NSInteger cid;

@property (nonatomic, copy) NSString *shortTitle;

@property (nonatomic, copy) NSString *longTitle;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, assign) BOOL is_External_url;

@end

NS_ASSUME_NONNULL_END
