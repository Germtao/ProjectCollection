//
//  TTDeleteCellView.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 删除 cell 浮层
@interface TTDeleteCellView : UIView

/// 点击删除出现删除cell确认浮层
/// @param point 点击位置
/// @param deleteBlock 点击确认删除后的回调
- (void)showFromPoint:(CGPoint)point clickDeleteBlock:(dispatch_block_t)deleteBlock;

@end

NS_ASSUME_NONNULL_END
