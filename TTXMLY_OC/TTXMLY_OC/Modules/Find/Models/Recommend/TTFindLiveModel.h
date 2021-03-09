//
//  TTFindLiveModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseModel.h"

@class TTFindLiveDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface TTFindLiveModel : TTBaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) NSMutableArray<TTFindLiveDetailModel *> *data;

@end

@interface TTFindLiveDetailModel : TTBaseModel

/// 频道 id
@property (nonatomic, assign) NSInteger chatId;

/// 封面地址
@property (nonatomic, copy) NSString *coverPath;

@property (nonatomic, assign) NSInteger endTs;

/// 唯一标识
@property (nonatomic, assign) NSInteger cid;

/// 名称
@property (nonatomic, copy) NSString *name;

/// 在线数量
@property (nonatomic, assign) NSInteger onlineCount;

/// 播放量
@property (nonatomic, assign) NSInteger playCount;

@property (nonatomic, assign) NSInteger scheduleId;

/// 简介
@property (nonatomic, copy) NSString *shortDescription;

@property (nonatomic, assign) NSInteger startTs;

@property (nonatomic, assign) NSInteger status;

@end

NS_ASSUME_NONNULL_END
