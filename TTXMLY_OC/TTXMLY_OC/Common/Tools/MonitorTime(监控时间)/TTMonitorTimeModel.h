//
//  TTMonitorTimeModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTMonitorTimeModel : NSObject

/// 方法名
@property (nonatomic, copy) NSString *functionName;

/// 消耗时间
@property (nonatomic, assign) CGFloat consumeTime;

/// 方法地址
@property (nonatomic, copy) NSString *functionAddress;

@end

NS_ASSUME_NONNULL_END
