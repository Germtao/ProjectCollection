//
//  TTFindRecommendHeader.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import <UIKit/UIKit.h>
#import "TTFindRecommendModel.h"
#import "TTFindHotGuessModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindRecommendHeader : UIView

/// 轮播图模型
@property (nonatomic, strong) TTFindFocusImagesModel *focusImages;

/// 分类模型
@property (nonatomic, strong) TTFindDiscoverColumnsModel *discoveryColumns;

+ (instancetype)findRecommendHeader;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
