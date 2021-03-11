//
//  TTFindRecommendModel.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTFindRecommendModel.h"

@implementation TTFindRecommendModel

@end

@implementation TTFindEditorRecommendAlbumModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"list" : [TTFindEditorRecommendDetailModel class]
    };
}

@end

@implementation TTFindSpecialColumnModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [TTFindSpecialColumnDetailModel class]};
}

@end

@implementation TTFindFocusImagesModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [TTFindFocusImageDetailModel class]};
}

@end

@implementation TTFindEditorRecommendDetailModel

@end

@implementation TTFindSpecialColumnDetailModel

@end

@implementation TTFindFocusImageDetailModel

@end
