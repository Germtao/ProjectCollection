//
//  TTFindRecommendHeader.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTFindRecommendHeader.h"
#import <UIImageView+YYWebImage.h>
#import "TTIconButtonView.h"
#import "TTFindRecommendHelper.h"

@interface TTFindRecommendHeader () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *bannerView;

@property (nonatomic, weak) IBOutlet UIScrollView *categoryView;

@end

@implementation TTFindRecommendHeader

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerChanged) name:kNotificationFindRecommendHeaderTimer object:nil];
}

+ (instancetype)findRecommendHeader {
    NSString *identifier = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil].firstObject;
}

#pragma mark - Setter

- (void)setFocusImages:(TTFindFocusImagesModel *)focusImages {
    _focusImages = focusImages;
    
    [self.bannerView removeAllSubviews];
    
    self.bannerView.contentSize = CGSizeMake(kScreenWidth * focusImages.list.count, self.size.height * 0.6);
    
    for (NSInteger i = 0; i <= focusImages.list.count; i++) {
        TTFindFocusImageDetailModel *detail = i == focusImages.list.count ? focusImages.list.firstObject : [focusImages.list objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, self.size.height * 0.6);
        [imageView yy_setImageWithURL:[NSURL URLWithString:detail.pic]
                              options:YYWebImageOptionSetImageWithFadeAnimation];
        [self.bannerView addSubview:imageView];
    }
}

- (void)setDiscoveryColumns:(TTFindDiscoverColumnsModel *)discoveryColumns {
    _discoveryColumns = discoveryColumns;
    
    [self.categoryView removeAllSubviews];
    
    self.categoryView.contentSize = CGSizeMake(71 * discoveryColumns.list.count, self.size.height * 0.4 - 10);
    
    for (NSInteger i = 0; i < discoveryColumns.list.count; i++) {
        TTFindDiscoverDetailModel *detail = [discoveryColumns.list objectAtIndex:i];
        
        TTIconButtonView *iconButton = [TTIconButtonView iconButtonView];
        iconButton.detailModel = detail;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(71 * i, 0, 71, self.size.height * 0.4 - 10)];
        [view addSubview:iconButton];
        [self.categoryView addSubview:view];
    }
}

#pragma mark - Action

- (void)timerChanged {
    if (!_focusImages) {
        return;
    }
    
    NSInteger currentIndex = self.bannerView.contentOffset.x / kScreenWidth;
    [self.bannerView setContentOffset:CGPointMake((currentIndex + 1) * kScreenWidth, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = self.bannerView.contentOffset.x / kScreenWidth;
    if (currentPage == self.focusImages.list.count) {
        [self.bannerView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[TTFindRecommendHelper sharedInstance] stopTimer:TTFindRecommendTimer_Banner];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[TTFindRecommendHelper sharedInstance] startTimer:TTFindRecommendTimer_Banner];
}

@end
