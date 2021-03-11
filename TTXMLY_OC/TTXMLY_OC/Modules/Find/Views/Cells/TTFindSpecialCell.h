//
//  TTFindSpecialCell.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/11.
//

#import "TTFindBaseCell.h"
#import "TTFindRecommendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindSpecialCell : TTFindBaseCell

@property (nonatomic, strong) TTFindSpecialColumnModel *specialColumn;

+ (instancetype)findCellStyleSpecial:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
