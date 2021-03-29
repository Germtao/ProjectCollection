//
//  TTVideoToolBar.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import <UIKit/UIKit.h>
#import "TTScreen.h"

NS_ASSUME_NONNULL_BEGIN

#define TTVideoToolBarHeight UI(60)

@interface TTVideoToolBar : UIView

/// 根据数据布局 ToolBar
- (void)layoutWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
