//
//  TTFindFeeCell.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindFeeCell.h"
#import <UIImageView+YYWebImage.h>

@interface TTFindFeeCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *moreButton;
@property (nonatomic, weak) IBOutlet UIImageView *leftImageView;
@property (nonatomic, weak) IBOutlet UIImageView *centerImageView;
@property (nonatomic, weak) IBOutlet UIImageView *rightImageView;
@property (nonatomic, weak) IBOutlet UILabel *leftContent;
@property (nonatomic, weak) IBOutlet UILabel *centerContent;
@property (nonatomic, weak) IBOutlet UILabel *rightContent;
@property (nonatomic, weak) IBOutlet UIButton *leftSubContent;
@property (nonatomic, weak) IBOutlet UIButton *centerSubContent;
@property (nonatomic, weak) IBOutlet UIButton *rightSubContent;

@end

@implementation TTFindFeeCell

#pragma mark - setter

- (void)setRecommendAlbum:(TTFindEditorRecommendAlbumModel *)recommendAlbum {
    _recommendAlbum = recommendAlbum;
    
    self.titleLabel.text = recommendAlbum.title;
    
    [self setSubDetailsWithDetails:recommendAlbum.list];
}

- (void)setCityColumn:(TTCityColumnModel *)cityColumn {
    _cityColumn = cityColumn;
    
    self.titleLabel.text = cityColumn.title;
    
    [self setSubDetailsWithDetails:cityColumn.list];
}

- (void)setHotRecommendItem:(TTFindHotRecommendItemModel *)hotRecommendItem {
    _hotRecommendItem = hotRecommendItem;
    
    self.titleLabel.text = hotRecommendItem.title;
    
    [self setSubDetailsWithDetails:hotRecommendItem.list];
}

// MARK: - private

- (void)setSubDetailsWithDetails:(NSMutableArray<TTFindEditorRecommendDetailModel *> *)details {
    Log(@"%ld", details.count);
    for (NSInteger i = 0; i < details.count; i++) {
        TTFindEditorRecommendDetailModel *detail = [details objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:detail.coverMiddle];
        
        Log(@"coverMiddle = %@, url = %@", detail.coverMiddle, url);
        
        if (i == 0) {
            [self.leftImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.leftContent.text = detail.intro;
            [self.leftSubContent setTitle:detail.title forState:UIControlStateNormal];
        } else if (i == 1) {
            [self.centerImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.centerContent.text = detail.intro;
            [self.centerSubContent setTitle:detail.title forState:UIControlStateNormal];
        } else if (i == 2) {
            [self.rightImageView yy_setImageWithURL:url options:YYWebImageOptionSetImageWithFadeAnimation];
            self.rightContent.text = detail.intro;
            [self.rightSubContent setTitle:detail.title forState:UIControlStateNormal];
        }
    }
}

#pragma mark - init

+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleFee:tableView];
}

+ (instancetype)findCellStyleFee:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
