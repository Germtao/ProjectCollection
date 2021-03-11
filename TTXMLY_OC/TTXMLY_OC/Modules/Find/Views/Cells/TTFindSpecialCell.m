//
//  TTFindSpecialCell.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/11.
//

#import "TTFindSpecialCell.h"
#import <UIImageView+YYWebImage.h>

@interface TTFindSpecialCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UIImageView *topImageView;
@property (nonatomic, weak) IBOutlet UILabel *topTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *topSubtitleLabel;
@property (nonatomic, weak) IBOutlet UIButton *topDescBtn;

@property (nonatomic, weak) IBOutlet UIImageView *downImageView;
@property (nonatomic, weak) IBOutlet UILabel *downTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *downSubtitleLabel;
@property (nonatomic, weak) IBOutlet UIButton *downDescBtn;

@end

@implementation TTFindSpecialCell

#pragma mark - init

+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleSpecial:tableView];
}

+ (instancetype)findCellStyleSpecial:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

#pragma mark - setter

- (void)setSpecialColumn:(TTFindSpecialColumnModel *)specialColumn {
    _specialColumn = specialColumn;
    
    self.titleLabel.text = specialColumn.title;
    
    for (NSInteger i = 0; i < specialColumn.list.count; i++) {
        TTFindSpecialColumnDetailModel *detail = [specialColumn.list objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:detail.coverPath];
        
        if (i == 0) {
            [self.topImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.topTitleLabel.text = detail.title;
            self.topSubtitleLabel.text = detail.subtitle;
            [self.topDescBtn setTitle:detail.footnote forState:UIControlStateNormal];
        } else if (i == 1) {
            [self.downImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.downTitleLabel.text = detail.title;
            self.downSubtitleLabel.text = detail.subtitle;
            [self.downDescBtn setTitle:detail.footnote forState:UIControlStateNormal];
        }
    }
}

#pragma mark - action

- (IBAction)moreButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(findCellStyleSpecial:didMoreClickedWithModel:)]) {
        [self.delegate findCellStyleSpecial:self didMoreClickedWithModel:self.specialColumn];
    }
}

@end
