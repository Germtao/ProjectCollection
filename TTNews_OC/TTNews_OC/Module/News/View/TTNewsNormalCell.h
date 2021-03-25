//
//  TTNewsNormalCell.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTListItem, TTNewsNormalCell;

@protocol TTNewsNormalCellDelegate <NSObject>

/// 点击删除cell按钮
- (void)newsNormalCell:(TTNewsNormalCell *)cell clickDeleteButton:(UIButton *)deleteButton;

@end

/// 新闻列表 cell
@interface TTNewsNormalCell : UITableViewCell

@property (nonatomic, weak) id <TTNewsNormalCellDelegate> delegate;

- (void)layoutUIWithItem:(TTListItem *)item;

@end

NS_ASSUME_NONNULL_END
