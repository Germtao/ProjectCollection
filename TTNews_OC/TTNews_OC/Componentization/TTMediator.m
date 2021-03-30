//
//  TTMediator.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import "TTMediator.h"

@implementation TTMediator

#pragma mark - Target - Action

/// 抽离业务逻辑
/// 通过中间层进行调用
/// 中间层使用 runtime 反射
/// 中间层代码优化
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl {
    Class vcClass = NSClassFromString(@"TTNewsDetailViewController");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIViewController *detailVc = [[vcClass alloc] performSelector:NSSelectorFromString(@"initWithUrlString:")
                                                       withObject:detailUrl];
#pragma clang diagnostic pop
    return detailVc;
}

@end
