//
//  TTMonitorTimeTool.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/15.
//

#import "TTMonitorTimeTool.h"
#import "BSBacktraceLogger.h"
#import "TTMonitorTimeModel.h"
#import "UIViewController+Common.h"

#define MonitoringInterval 0.01       // 监控的时间间隔，建议0.01秒最佳

@interface TTMonitorTimeTool ()

/// 监控定时器
@property (nonatomic, strong) dispatch_source_t monitorTimer;

/// 日志定时器
@property (nonatomic, strong) dispatch_source_t logTimer;

/// 调用栈 Map
@property (nonatomic, strong) NSMutableDictionary *callStackDict;

/// 控制器白名单，想要监控的白名单
@property (nonatomic, strong) NSMutableArray *whiteList;

@end

@implementation TTMonitorTimeTool

+ (instancetype)sharedInstance {
    static TTMonitorTimeTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTMonitorTimeTool alloc] init];
    });
    return instance;
}

#pragma mark - Public

- (void)startMonitoringTimer {
    self.monitorTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    self.callStackDict = [NSMutableDictionary dictionary];
    dispatch_source_set_timer(self.monitorTimer, dispatch_walltime(NULL, 0), MonitoringInterval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.monitorTimer, ^{
        // key-代表方法调用地址 value-代表方法调用名称
        NSDictionary *mainThreadCallStackMap = [BSBacktraceLogger bs_backtraceMapOfMainThread];
        for (NSString *funcAddress in mainThreadCallStackMap.allKeys) {
            NSString *funcName = [mainThreadCallStackMap objectForKey:funcAddress];
            TTMonitorTimeModel *model = [self.callStackDict objectForKey:funcAddress];
            if (model == nil) {
                model = [TTMonitorTimeModel new];
                model.functionName = funcName;
                model.consumeTime = MonitoringInterval;
                model.functionAddress = funcAddress;
                [self.callStackDict setObject:model forKey:funcAddress];
            } else {
                model.consumeTime += MonitoringInterval;
            }
        }
    });
    dispatch_resume(self.monitorTimer);
}

- (void)stopMonitoringTimer {
    dispatch_source_cancel(self.monitorTimer);
}

- (void)manualShowLog {
    [self performSelector:@selector(addLogButton) withObject:nil afterDelay:0.1];
}

- (void)logAllCallStack {
    NSMutableString *resultString = [NSMutableString stringWithFormat:@""];
    for (NSString *key in self.callStackDict.allKeys) {
        TTMonitorTimeModel *model = [self.callStackDict objectForKey:key];
        if (model.functionName && model.consumeTime > MonitoringInterval) {
            [resultString appendFormat:@"%@的耗时为：%.2f \n\n\n", model.functionName, model.consumeTime];
        }
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"主线程中所有的方法耗时(误差0.1s)" message:[resultString copy] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sureAction];
    [[UIViewController currentViewController] presentViewController:alert animated:YES completion:nil];
}

#pragma mark - private

- (void)addLogButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"显示方法耗时日志" forState:UIControlStateNormal];
    [btn sizeToFit];
    
    CGFloat width = btn.frame.size.width;
    btn.frame = CGRectMake((kScreenWidth - width - 20), kStatusBarHeight + (kTopBarHeight - kStatusBarHeight - 20) / 2, width, 20);
    [btn addTarget:self action:@selector(logAllCallStack) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:btn];
    [keyWindow bringSubviewToFront:btn];
}

/// 自动显示日志
//- (void)autoShowLog{
//    self.logTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(self.logTimer, dispatch_walltime(NULL, 0), 5 * NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(self.logTimer, ^{
//        [self logAllCallStack];
//    });
//    dispatch_resume(self.logTimer);
//}
//
///// 取消自动显示日志
//- (void)closeAutoShowLog{
//    dispatch_source_cancel(self.logTimer);
//}

@end
