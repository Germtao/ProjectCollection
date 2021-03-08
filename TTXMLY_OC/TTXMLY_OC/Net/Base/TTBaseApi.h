//
//  TTBaseApi.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "TTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TTBaseApiCompletion)(id _Nullable response, NSString * _Nullable message, BOOL success);

@interface TTBaseApi : NSObject

+ (NSMutableDictionary *)params;

@end

NS_ASSUME_NONNULL_END
