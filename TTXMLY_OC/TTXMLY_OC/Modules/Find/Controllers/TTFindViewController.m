//
//  TTFindViewController.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTFindViewController.h"
#import "TTFindSubTitleView.h"
#import <Masonry/Masonry.h>
#import "TTFindSubFactory.h"

#define kXMLYBGGray [UIColor colorWithRed:0.92f green:0.93f blue:0.93f alpha:1.00f]

@interface TTFindViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, TTFindSubTitleViewDelegate>

@property (nonatomic, weak) IBOutlet TTFindSubTitleView *subTitleView;

@property (nonatomic, strong) NSMutableArray *subTitleArray;

@property (nonatomic, strong) NSMutableArray *subControllers;

@property (nonatomic, weak) UIPageViewController *pageVc;

@end

@implementation TTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

- (void)makeUI {
    self.view.backgroundColor = kXMLYBGGray;
    self.subTitleView.delegate = self;
    self.subTitleView.titleArray = self.subTitleArray;
    
    [self.pageVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBarHeight);
    }];
}

// MARK: - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.subControllers objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if (index == self.subControllers.count - 1 || index == NSNotFound) {
        return nil;
    }
    return [self.subControllers objectAtIndex:index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.subControllers.count;
}

// MARK: - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *vc = self.pageVc.viewControllers[0];
    NSUInteger index = [self indexForViewController:vc];
    [self.subTitleView transform2ShowAtIndex:index];
}

// MARK: - TTFindSubTitleViewDelegate
- (void)findSubTitleViewDidSelected:(TTFindSubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title {
    [self.pageVc setViewControllers:@[[self.subControllers objectAtIndex:index]]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:NO
                         completion:nil];
}

// MARK: - Private

- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.subControllers indexOfObject:controller];
}

// MARK: - Getter

- (UIPageViewController *)pageVc {
    if (!_pageVc) {
        NSNumber *number = [NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone];
        NSDictionary *options = [NSDictionary dictionaryWithObject:number
                                                            forKey:UIPageViewControllerOptionSpineLocationKey];
        
        UIPageViewController *pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        pageVc.delegate = self;
        pageVc.dataSource = self;
        [pageVc setViewControllers:@[[self.subControllers firstObject]]
                         direction:UIPageViewControllerNavigationDirectionForward
                          animated:NO
                        completion:nil];
        [self addChildViewController:pageVc];
        [self.view addSubview:pageVc.view];
        _pageVc = pageVc;
    }
    return _pageVc;
}

- (NSMutableArray *)subControllers {
    if (!_subControllers) {
        _subControllers = [NSMutableArray array];
        for (NSString *title in self.subTitleArray) {
            TTBaseChildViewController *subVc = [TTFindSubFactory subControllerWithIdentifier:title];
            [_subControllers addObject:subVc];
        }
    }
    return _subControllers;
}

- (NSMutableArray *)subTitleArray {
    if (!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"推荐", @"分类", @"广播", @"榜单", @"主播", nil];
    }
    return _subTitleArray;
}

@end
