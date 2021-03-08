//
//  TTBaseRequest.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TTHttpType) {
    TTHttpType_GET,
    TTHttpType_POST,
};

typedef void(^TTHttpRequestCompletion)(id _Nullable responseObject,NSString * _Nullable message, BOOL success);

@interface TTBaseRequest : NSObject

/// 设置请求地址
+ (instancetype)requestWithURL:(NSString *)url;

/// 发送网络请求
/// @param methodType 请求方式 GET POST
/// @param params     请求参数
/// @param completion 请求完成回调
- (NSURLSessionDataTask *)startWithMethod:(TTHttpType)methodType
                                   params:(nullable id)params
                               completion:(TTHttpRequestCompletion)completion;

@end

NS_ASSUME_NONNULL_END
