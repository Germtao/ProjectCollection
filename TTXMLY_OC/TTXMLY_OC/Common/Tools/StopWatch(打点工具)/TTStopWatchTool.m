//
//  TTStopWatchTool.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/12.
//

#import "TTStopWatchTool.h"
#import <pthread/pthread.h>

typedef NS_ENUM(NSInteger, TTStopWatchState) {
    TTStopWatchState_Initial = 0,
    TTStopWatchState_Running,
    TTStopWatchState_Stop
};

@interface TTStopWatchTool ()

@property (nonatomic) CFTimeInterval startTimeInterval;
@property (nonatomic) CFTimeInterval temporaryTimeInterval;
@property (nonatomic) CFTimeInterval stopTimeInterval;
@property (nonatomic, strong) NSMutableArray<NSDictionary<NSString *, NSNumber *> *> *mutableSplits;
@property (nonatomic) TTStopWatchState state;
@property (nonatomic) pthread_mutex_t lock;

@end

@implementation TTStopWatchTool

#pragma mark - cycle

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

+ (instancetype)sharedInstance {
    static TTStopWatchTool *stopwatch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stopwatch = [[TTStopWatchTool alloc] init];
    });
    return stopwatch;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _mutableSplits = [NSMutableArray array];
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

#pragma mark - public

- (void)start {
    self.state = TTStopWatchState_Running;
    
    self.startTimeInterval = CACurrentMediaTime();
    self.temporaryTimeInterval = self.startTimeInterval;
}

- (void)splitWithDescription:(NSString *)description {
    [self splitWithType:TTStopWatchSplitType_Median description:description];
}

- (void)splitWithType:(TTStopWatchSplitType)type description:(NSString *)description {
    if (self.state != TTStopWatchState_Running) {
        return;
    }
    
    NSTimeInterval tempTimeInterval = CACurrentMediaTime();
    CFTimeInterval splitTimeInterval = type == TTStopWatchSplitType_Median ? tempTimeInterval - self.temporaryTimeInterval : tempTimeInterval - self.startTimeInterval;
    
    NSInteger count = self.mutableSplits.count + 1;
    
    NSMutableString *finalDescription = [NSMutableString stringWithFormat:@"#%@", @(count)];
    if (description) {
        [finalDescription appendFormat:@"--%@", description];
    }
    
    pthread_mutex_lock(&_lock);
    [self.mutableSplits addObject:@{finalDescription : @(splitTimeInterval)}];
    pthread_mutex_unlock(&_lock);
    self.temporaryTimeInterval = tempTimeInterval;
}

- (void)refreshMedianTime {
    self.temporaryTimeInterval = CACurrentMediaTime();
}

- (void)stop {
    self.state = TTStopWatchState_Stop;
    self.stopTimeInterval = CACurrentMediaTime();
}

- (void)reset {
    self.state = TTStopWatchState_Initial;
    pthread_mutex_lock(&_lock);
    [self.mutableSplits removeAllObjects];
    pthread_mutex_unlock(&_lock);
    self.startTimeInterval = 0;
    self.stopTimeInterval = 0;
    self.temporaryTimeInterval = 0;
}

- (void)stopAndPresentResultsThenReset:(UIViewController *)vc {
    [[TTStopWatchTool sharedInstance] stop];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TTStopWatch 结果"
                                                                   message:[[TTStopWatchTool sharedInstance] prettyPrintedSplits]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sureAction];
    [vc presentViewController:alert animated:true completion:nil];
}

#pragma mark - getter

- (NSArray<NSDictionary<NSString *,NSNumber *> *> *)splits {
    pthread_mutex_lock(&_lock);
    NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *array = [self.mutableSplits copy];
    pthread_mutex_unlock(&_lock);
    return array;
}

- (NSString *)prettyPrintedSplits {
    NSMutableString *output = [[NSMutableString alloc] init];
    pthread_mutex_lock(&_lock);
    [self.mutableSplits enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [output appendFormat:@"%@: %.3f\n", obj.allKeys.firstObject, obj.allValues.firstObject.doubleValue];
    }];
    pthread_mutex_unlock(&_lock);
    
    return [output copy];
}

- (NSTimeInterval)elapseTimeInterval {
    switch (self.state) {
        case TTStopWatchState_Initial:
            return 0;
        case TTStopWatchState_Running:
            return CACurrentMediaTime() - self.startTimeInterval;
        case TTStopWatchState_Stop:
            return self.stopTimeInterval - self.startTimeInterval;
    }
}

@end
