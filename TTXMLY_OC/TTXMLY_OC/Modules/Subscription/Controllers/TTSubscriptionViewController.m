//
//  TTSubscriptionViewController.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTSubscriptionViewController.h"
#import "TTSubscriptionNavView.h"
#import <Masonry/Masonry.h>

@interface TTSubscriptionViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) TTSubscriptionNavView *navView;

@property (nonatomic, strong) NSMutableArray *subControllers;

@property (nonatomic, weak) UIPageViewController *pageVc;

@property (nonatomic, assign) TTSubscriptionStyle style;

@end

@implementation TTSubscriptionViewController

+ (instancetype)subscriptionVcWithStyle:(TTSubscriptionStyle)style {
    return [[self alloc] initSubscriptionViewWithStyle:style];
}

- (instancetype)initSubscriptionViewWithStyle:(TTSubscriptionStyle)style {
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

- (void)makeUI {
    self.navigationItem.titleView = _navView;
    [_pageVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBarHeight);
    }];
}

#pragma mark - UIPageViewControllerDataSource

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

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *vc = self.pageVc.viewControllers[0];
    NSUInteger index = [self indexForViewController:vc];
    [self.navView transformToControllerAtIndex:index];
}

#pragma mark - Private

- (NSInteger)indexForViewController:(UIViewController *)vc {
    return [self.subControllers indexOfObject:vc];
}

- (void)navigationDidSelectedControllerAtIndex:(NSInteger)index {
    [self.pageVc setViewControllers:@[[self.subControllers objectAtIndex:index]]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:NO
                         completion:nil];
}

#pragma mark - Getter

- (TTSubscriptionNavView *)navView {
    if (!_navView) {
        NSArray *titleArray = [TTSubscriptionFactory subTitlesWithStyle:self.style];
        
        _navView = [TTSubscriptionNavView navViewWithTitles:titleArray];
        __weak typeof(self) weakSelf = self;
        _navView.navViewDidClicked = ^(TTSubscriptionNavView * _Nonnull navView, NSInteger index) {
            __strong typeof(weakSelf) self = weakSelf;
            [self navigationDidSelectedControllerAtIndex:index];
        };
    }
    return _navView;
}

- (NSMutableArray *)subControllers {
    if (!_subControllers) {
        _subControllers = [[TTSubscriptionFactory subControllersWithStyle:self.style] mutableCopy];
    }
    return _subControllers;
}

- (UIPageViewController *)pageVc {
    if (!_pageVc) {
        UIPageViewController *pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [pageVc willMoveToParentViewController:self];
        pageVc.delegate = self;
        pageVc.dataSource = self;
        [self addChildViewController:pageVc];
        [self.view addSubview:pageVc.view];
        [pageVc setViewControllers:@[self.subControllers.firstObject]
                         direction:UIPageViewControllerNavigationDirectionForward
                          animated:YES
                        completion:nil];
        _pageVc = pageVc;
    }
    return _pageVc;
}

@end
