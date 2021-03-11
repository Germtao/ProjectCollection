//
//  TTFindCellFactory.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "TTFindBaseCell.h"
#import "TTFindFeeCell.h"
#import "TTFindLiveCell.h"
#import "TTFindSpecialCell.h"
#import "TTFindMoreCell.h"

typedef NS_ENUM(NSInteger, TTFindCellStyle) {
    TTFindCellStyle_Fee     = 0, // 类似付费精品
    TTFindCellStyle_Live    = 1, // 直播
    TTFindCellStyle_Special = 2, // 精品听单
    TTFindCellStyle_More    = 3, // 更多
};

NS_ASSUME_NONNULL_BEGIN

@interface TTFindCellFactory : NSObject

+ (TTFindBaseCell *)createCell:(UITableView *)tableView style:(TTFindCellStyle)style;

@end

NS_ASSUME_NONNULL_END
