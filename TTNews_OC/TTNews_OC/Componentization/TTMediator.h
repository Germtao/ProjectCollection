//
//  TTMediator.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TTMediatorProcessBlock)(NSDictionary *params);

@protocol TTDetailViewControllerProtocol <NSObject>

- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

@end

/// 常用的三种组件化方案
@interface TTMediator : NSObject

#pragma mark - Target - Action

/// 抽离业务逻辑
/// 通过中间层进行调用
/// 中间层使用 runtime 反射
/// 中间层代码优化
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

#pragma mark - URL Scheme

/// 使用 URL 处理本地跳转
/// 通过中间层进行注册 & 调用
/// 注册表无需使用反射
/// 非懒加载 / 注册表的维护 / 参数
+ (void)registerScheme:(NSString *)scheme processBlock:(TTMediatorProcessBlock)processBlock;
+ (void)openUrl:(NSString *)url parameters:(NSDictionary *)params;

#pragma mark - Protocol - Class

/// 增加 Protocol Wrapper 层
/// 中间件返回 Protocol 对应的 Class
/// 解决硬编码的问题
+ (void)registerProtocol:(Protocol *)protocol withClass:(Class)withClass;
+ (Class)classForProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
