//
//  TTSubscriptionFactory.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTSubscriptionFactory.h"

@implementation TTSubscriptionFactory

+ (NSArray *)subControllersWithStyle:(TTSubscriptionStyle)style {
    NSArray *controllers = nil;
    switch (style) {
        case TTSubscriptionStyle_Subscription:
            controllers = @[];
            break;
        case TTSubscriptionStyle_Download:
            controllers = @[];
            break;
    }
    return controllers;
}

+ (NSArray *)subTitlesWithStyle:(TTSubscriptionStyle)style {
    NSArray *titles = nil;
    switch (style) {
        case TTSubscriptionStyle_Subscription:
            titles = @[@"推荐", @"订阅", @"历史"];
            break;
        case TTSubscriptionStyle_Download:
            titles = @[@"专辑", @"声音", @"下载中"];
            break;
    }
    return titles;
}

@end
