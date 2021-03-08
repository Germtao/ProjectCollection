//
//  TTBaseRequest.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTBaseRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface TTBaseRequest ()

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) TTHttpRequestCompletion completionBlock;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation TTBaseRequest

+ (instancetype)requestWithURL:(NSString *)url {
    TTBaseRequest *request = [[TTBaseRequest alloc] init];
    request.urlString = url;
    return request;
}

- (NSURLSessionDataTask *)startWithMethod:(TTHttpType)methodType
                                   params:(nullable id)params
                               completion:(TTHttpRequestCompletion)completion {
    NSURLSessionDataTask *task = nil;
    self.completionBlock = completion;
    self.sessionManager = [self sessionManagerWithParams:params];
    NSString *urlString = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];
    
    if (methodType == TTHttpType_GET) {
        task = [self.sessionManager GET:urlString
                             parameters:params
                                headers:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, YES);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.completionBlock) {
                self.completionBlock(nil, error.description, NO);
            }
        }];
    } else if (methodType == TTHttpType_POST) {
        task = [self.sessionManager POST:urlString
                              parameters:params
                                 headers:nil
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, YES);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.completionBlock) {
                self.completionBlock(nil, error.description, NO);
            }
        }];
    }
    return nil;
}

- (AFHTTPSessionManager *)sessionManagerWithParams:(NSDictionary *)params {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.0f;
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",  @"text/json", @"text/javascript", @"text/html", nil];
    return sessionManager;
}

@end
