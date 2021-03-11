//
//  TTFindMoreCell.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/11.
//

#import "TTFindMoreCell.h"

@implementation TTFindMoreCell

+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleMore:tableView];
}

+ (instancetype)findCellStyleMore:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
