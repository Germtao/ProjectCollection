//
//  TTStopWatchTool.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTStopWatchSplitType) {
    TTStopWatchSplitType_Median = 0, // 记录中间值
    TTStopWatchSplitType_Continuous, // 记录连续值
};

NS_ASSUME_NONNULL_BEGIN

@interface TTStopWatchTool : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) NSArray<NSDictionary<NSString *, NSNumber *> *> *splits;
@property (nonatomic, readonly) NSString *prettyPrintedSplits;
@property (nonatomic, readonly) NSTimeInterval elapseTimeInterval;

/// 开始记录
- (void)start;

/// 打点（默认记录中间值）
/// @param description 描述信息
- (void)splitWithDescription:(NSString *_Nullable)description;

/// 打点
/// @param type 记录类型
/// @param description 描述信息
- (void)splitWithType:(TTStopWatchSplitType)type description:(NSString *_Nullable)description;

/// 刷新中间值
- (void)refreshMedianTime;

/// 停止记录
- (void)stop;

/// 重设
- (void)reset;

- (void)stopAndPresentResultsThenReset:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
