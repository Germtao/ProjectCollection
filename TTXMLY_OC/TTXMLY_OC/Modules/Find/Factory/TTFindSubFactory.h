//
//  TTFindSubFactory.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "TTFindBaseViewController.h"

typedef NS_ENUM(NSInteger, TTFindSubVCType) {
    TTFindSubVCType_Recommend = 0, // 推荐
    TTFindSubVCType_Category  = 1, // 分类
    TTFindSubVCType_Radio     = 2, // 广播
    TTFindSubVCType_Rank      = 3, // 榜单
    TTFindSubVCType_Anchor    = 4, // 主播
    TTFindSubVCType_Unknown   = 5, // 未知
};

NS_ASSUME_NONNULL_BEGIN

@interface TTFindSubFactory : NSObject

/// 生成自控制器
/// @param identifier 控制器唯一标识
+ (TTFindBaseViewController *)subControllerWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
