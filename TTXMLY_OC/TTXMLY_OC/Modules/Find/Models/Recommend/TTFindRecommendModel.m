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

@end

@implementation TTFindSpecialColumnModel

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
