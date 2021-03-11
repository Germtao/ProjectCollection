//
//  TTFindBaseCell.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TTFindCellStyle) {
    TTFindCellStyle_Fee     = 0, // 类似付费精品
    TTFindCellStyle_Live    = 1, // 直播
    TTFindCellStyle_Special = 2, // 精品听单
    TTFindCellStyle_More    = 3, // 更多
};

@class TTFindFeeCell, TTFindLiveCell, TTFindSpecialCell,
TTFindLiveModel, TTFindSpecialColumnModel;

@protocol TTFindBaseCellDelegate <NSObject>

- (void)findCellStyleFeeDidMoreClicked:(TTFindFeeCell *_Nonnull)cell;
- (void)findCellStyleLive:(TTFindLiveCell *_Nonnull)cell didMoreClickedWithModel:(TTFindLiveModel *_Nonnull)model;
- (void)findCellStyleSpecial:(TTFindSpecialCell *_Nonnull)cell didMoreClickedWithModel:(TTFindSpecialColumnModel *_Nonnull)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TTFindBaseCell : UITableViewCell

+ (instancetype)findCell:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
