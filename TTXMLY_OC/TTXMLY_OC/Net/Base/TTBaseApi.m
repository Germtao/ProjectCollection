//
//  TTBaseApi.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTBaseApi.h"

@implementation TTBaseApi

+ (NSMutableDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"iPhone" forKey:@"device"];
    return params;
}

@end
