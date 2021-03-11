//
//  TTFindLiveCell.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTFindLiveCell.h"
#import "TTFindRecommendHelper.h"
#import <UIImageView+YYWebImage.h>

@interface TTFindLiveCell () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UILabel *peopleCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *subcontentLabel;

@end

@implementation TTFindLiveCell

#pragma mark - init

+ (instancetype)findCell:(UITableView *)tableView {
    return [self findCellStyleLive:tableView];
}

+ (instancetype)findCellStyleLive:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus) name:kNotificationFindRecommendLiveTimer object:nil];
}

#pragma mark - setter

- (void)setLiveModel:(TTFindLiveModel *)liveModel {
    _liveModel = liveModel;
    
    self.titleLabel.text = @"现场直播";
    
    [self.scrollView removeAllSubviews];
    
    for (NSInteger i = 0; i <= liveModel.data.count; i++) {
        TTFindLiveDetailModel *detail = [liveModel.data objectAtIndex:i == liveModel.data.count ? 0 : i];
        
        if (i == 0) {
            [self setLabelText:detail];
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((kScreenWidth - 20) * i, 0, kScreenWidth - 20, 108);
        [self.scrollView addSubview:imageView];
        
        [imageView yy_setImageWithURL:[NSURL URLWithString:detail.coverPath]
                              options:YYWebImageOptionSetImageWithFadeAnimation];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / (kScreenWidth - 20);
    if (currentPage == _liveModel.data.count) {
        [self.scrollView setContentOffset:CGPointZero animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[TTFindRecommendHelper sharedInstance] stopTimer:TTFindRecommendTimer_Live];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[TTFindRecommendHelper sharedInstance] startTimer:TTFindRecommendTimer_Live];
}

#pragma mark - private

- (IBAction)moreButtonClicked:(UIButton *)sender {
    
}

- (void)changeStatus {
    if (!_liveModel) {
        return;
    }
    
    NSInteger currentIndex = self.scrollView.contentOffset.x / (kScreenWidth - 20);
    
    NSInteger index;
    if (currentIndex + 1 == _liveModel.data.count) {
        index = 0;
        [self.scrollView setContentOffset:CGPointZero animated:NO];
    } else {
        index = currentIndex;
        [self.scrollView setContentOffset:CGPointMake((kScreenWidth - 20) * (currentIndex + 1), 0) animated:YES];
    }
    
    TTFindLiveDetailModel *detail = [_liveModel.data objectAtIndex:index];
    [self setLabelText:detail];
}

- (void)setLabelText:(TTFindLiveDetailModel *)detail {
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%ld人参加", detail.onlineCount];
    self.contentLabel.text = detail.name;
    self.subcontentLabel.text = detail.shortDescription;
}

@end
