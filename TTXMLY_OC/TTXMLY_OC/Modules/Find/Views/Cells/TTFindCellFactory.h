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

NS_ASSUME_NONNULL_BEGIN

@interface TTFindCellFactory : NSObject

+ (TTFindBaseCell *)createCell:(UITableView *)tableView style:(TTFindCellStyle)style;

@end

NS_ASSUME_NONNULL_END
