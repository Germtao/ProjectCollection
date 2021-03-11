//
//  TTFindCellFactory.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindCellFactory.h"
#import "TTFindFeeCell.h"
#import "TTFindLiveCell.h"

@implementation TTFindCellFactory

+ (TTFindBaseCell *)createCell:(UITableView *)tableView style:(TTFindCellStyle)style {
    TTFindBaseCell *cell;
    switch (style) {
        case TTFindCellStyle_Fee:
            cell = [TTFindFeeCell findCell:tableView];
            break;
        case TTFindCellStyle_Live:
            cell = [TTFindLiveCell findCell:tableView];
            break;
        default:
            cell = [TTFindBaseCell findCell:tableView];
            break;
    }
    return cell;
}

@end
