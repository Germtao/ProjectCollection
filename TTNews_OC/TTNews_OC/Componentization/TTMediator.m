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

#pragma mark - 注册表

+ (NSMutableDictionary *)mediatorCache {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

#pragma mark - URL Scheme

/// 使用 URL 处理本地跳转
/// 通过中间层进行注册 & 调用
/// 注册表无需使用反射
/// 非懒加载 / 注册表的维护 / 参数
+ (void)registerScheme:(NSString *)scheme processBlock:(TTMediatorProcessBlock)processBlock {
    if (scheme && processBlock) {
        [[[self class] mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url parameters:(NSDictionary *)params {
    TTMediatorProcessBlock processBlock = [[[self class] mediatorCache] objectForKey:url];
    if (processBlock) {
        processBlock(params);
    }
}

#pragma mark - Protocol - Class

/// 增加 Protocol Wrapper 层
/// 中间件返回 Protocol 对应的 Class
/// 解决硬编码的问题
+ (void)registerProtocol:(Protocol *)protocol withClass:(Class)withClass {
    if (protocol && withClass) {
        [[[self class] mediatorCache] setObject:withClass forKey:NSStringFromProtocol(protocol)];
    }
}

+ (Class)classForProtocol:(Protocol *)protocol {
    return [[[self class] mediatorCache] objectForKey:NSStringFromProtocol(protocol)];
}

@end
