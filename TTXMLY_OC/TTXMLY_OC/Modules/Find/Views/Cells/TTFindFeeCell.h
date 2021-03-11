//
//  TTFindFeeCell.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindBaseCell.h"
#import "TTFindRecommendModel.h"
#import "TTFindHotGuessModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindFeeCell : TTFindBaseCell

@property (nonatomic, weak) id <TTFindBaseCellDelegate> delegate;

@property (nonatomic, strong) TTFindEditorRecommendAlbumModel *recommendAlbum;

@property (nonatomic, strong) TTCityColumnModel *cityColumn;

@property (nonatomic, strong) TTFindHotRecommendItemModel *hotRecommendItem;

@property (nonatomic, strong) TTFindGuessULikeModel *guessULike;

+ (instancetype)findCellStyleFee:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
