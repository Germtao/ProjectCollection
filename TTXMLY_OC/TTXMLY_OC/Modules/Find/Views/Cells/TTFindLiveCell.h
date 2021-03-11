//
//  TTFindLiveCell.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindBaseCell.h"
#import "TTFindLiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFindLiveCell : TTFindBaseCell

@property (nonatomic, strong) TTFindLiveModel *liveModel;

+ (instancetype)findCellStyleLive:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
