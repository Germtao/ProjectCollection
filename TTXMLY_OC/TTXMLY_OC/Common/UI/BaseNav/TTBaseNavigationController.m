//
//  TTBaseNavigationController.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTBaseNavigationController.h"

@interface TTBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation TTBaseNavigationController

+ (void)initialize {
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = kFont(18.0);
    attributes[NSForegroundColorAttributeName] = Hex(0x333333);
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    
    NSMutableDictionary *itemAttri = [NSMutableDictionary dictionary];
    itemAttri[NSFontAttributeName] = kFont(15.0);
    itemAttri[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:itemAttri forState:UIControlStateNormal];
    
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:kIMAGE(@"btn_back_n") forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        btn.tintColor = [UIColor whiteColor];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        btn.clipsToBounds = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *gestureArr = self.navigationController.view.gestureRecognizers;
    
    // 当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArr) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            for (UIView *view in self.view.subviews) {
                if ([view isKindOfClass:[UIScrollView class]]) {
                    [[(UIScrollView *)view panGestureRecognizer] requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

@end
