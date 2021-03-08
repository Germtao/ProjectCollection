//
//  TTFindSubFactory.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTFindSubFactory.h"
#import "TTFindRecommendViewController.h"
#import "TTFindCategoryViewController.h"
#import "TTFindRadioViewController.h"
#import "TTFindRankViewController.h"
#import "TTFindAnchorViewController.h"

@implementation TTFindSubFactory

+ (TTFindBaseViewController *)subControllerWithIdentifier:(NSString *)identifier {
    TTFindSubVCType vcType = [self typeFromTitle:identifier];
    
    TTFindBaseViewController *controller = nil;
    
    switch (vcType) {
        case TTFindSubVCType_Recommend:
            controller = [[TTFindRecommendViewController alloc] init];
            break;
        case TTFindSubVCType_Category:
            controller = [[TTFindCategoryViewController alloc] init];
            break;
        case TTFindSubVCType_Radio:
            controller = [[TTFindRadioViewController alloc] init];
            break;
        case TTFindSubVCType_Rank:
            controller = [[TTFindRankViewController alloc] init];
            break;
        case TTFindSubVCType_Anchor:
            controller = [[TTFindAnchorViewController alloc] init];
            break;
        default:
            controller = [[TTFindBaseViewController alloc] init];
            break;
    }
    return controller;
}

+ (TTFindSubVCType)typeFromTitle:(NSString *)title {
    if ([title isEqualToString:@"推荐"]) {
        return TTFindSubVCType_Recommend;
    } else if ([title isEqualToString:@"分类"]) {
        return TTFindSubVCType_Category;
    } else if ([title isEqualToString:@"广播"]) {
        return TTFindSubVCType_Radio;
    } else if ([title isEqualToString:@"榜单"]) {
        return TTFindSubVCType_Rank;
    } else if ([title isEqualToString:@"主播"]) {
        return TTFindSubVCType_Anchor;
    } else {
        return TTFindSubVCType_Unknown;
    }
}

@end
