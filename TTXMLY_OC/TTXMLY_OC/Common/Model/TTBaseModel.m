//
//  TTBaseModel.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseModel.h"

@implementation TTBaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cid": @"id"};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"cid": @"id"};
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [self yy_modelEncodeWithCoder:coder];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    return [self yy_modelInitWithCoder:coder];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [self yy_modelCopy];
}

@end
