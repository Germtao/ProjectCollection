//
//  TTMonitorTimeTool.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTMonitorTimeTool : NSObject

+ (instancetype)sharedInstance;

/// 启动监控
- (void)startMonitoringTimer;

/// 停止监控
- (void)stopMonitoringTimer;

/// 打印所有方法耗时
- (void)logAllCallStack;

/// 手动显示日志
- (void)manualShowLog;

@end

NS_ASSUME_NONNULL_END
