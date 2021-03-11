//
//  TTFindHotGuessModel.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTFindHotGuessModel.h"

@implementation TTFindHotGuessModel

@end

@implementation TTFindDiscoverColumnsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindDiscoverDetailModel class]};
}

@end

@implementation TTFindDiscoverDetailModel

@end

@implementation TTFindDiscoverProperityModel

@end

@implementation TTFindGuessULikeModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindEditorRecommendDetailModel class]};
}

@end

@implementation TTCityColumnModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindEditorRecommendDetailModel class]};
}

@end

@implementation TTFindHotRecommendModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindHotRecommendItemModel class]};
}

@end

@implementation TTFindHotRecommendItemModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindEditorRecommendDetailModel class]};
}

@end
