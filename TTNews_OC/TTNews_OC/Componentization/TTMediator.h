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

@end

NS_ASSUME_NONNULL_END
