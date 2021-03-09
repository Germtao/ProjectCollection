//
//  TTRootViewController.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTRootViewController.h"
#import "TTBaseNavigationController.h"

#define kStoryBoardFind         @"Find"
#define kStoryBoardSubScribe    @"SubScribe"
#define kStoryBoardPlay         @"Play"
#define kStoryBoardDownLoad     @"Download"
#define kStoryBoardMine         @"Mine"

@interface TTRootViewController () <UITabBarControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *normalImageArray;

@property (nonatomic, strong) NSMutableArray *selectedImageArray;

@property (nonatomic, strong) NSArray *vcIdentifierArray;

@property (nonatomic, weak) UIImageView *bgImageView;

@end

@implementation TTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabBar];
    [self configChildControllers];
}

#pragma mark - Private

- (void)customTabBar {
    self.tabBar.hidden = YES;
    
    CGFloat width = kScreenWidth / 5.0f;
    
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 2) {
            btn.frame = CGRectMake((kScreenWidth - 49) / 2 - 5, -10, 49 + 10, 49 + 10);
            [btn setBackgroundImage:kIMAGE(@"tabbar_np_normal") forState:UIControlStateNormal];
            
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_shadow"]];
            CGFloat btnW = btn.frame.size.width + 6;
            img.frame = CGRectMake( -3 , -3, btnW , btnW * 13.0f / 15.0f);
            [btn addSubview:img];
            
        } else {
            btn.frame = CGRectMake(width * i, 0, width, 49);
        }
        btn.tag = 100 + i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[self.normalImageArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setImage:[self.selectedImageArray objectAtIndex:i] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tabBarItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgImageView addSubview:btn];
    }
    
    [self tabBarItemSelected:[self.bgImageView viewWithTag:100]];
}

- (void)configChildControllers {
    self.tabBar.hidden = YES;
    
    NSMutableArray *controllers = [NSMutableArray array];
    [self.vcIdentifierArray enumerateObjectsUsingBlock:^(NSString * _Nonnull identifier, NSUInteger idx, BOOL * _Nonnull stop) {
        TTBaseNavigationController *nav = [self navigationControllerWithIdentifier:identifier];
        nav.delegate = self;
        [controllers addObject:nav];
    }];
    
    self.viewControllers = controllers;
}

- (TTBaseNavigationController *)navigationControllerWithIdentifier:(NSString *)identifier {
    TTBaseNavigationController *nav = [[UIStoryboard storyboardWithName:identifier bundle:nil] instantiateInitialViewController];
    return nav;
}

- (BOOL)versionTabBarSelectedAtIndex:(NSInteger)index {
    if (index == 2) {
        return NO;
    }
    return YES;
}

#pragma mark - Action
- (void)tabBarItemSelected:(UIButton *)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    for (UIButton *btn in self.bgImageView.subviews) {
        if (btn.tag == sender.tag) {
            continue;
        }
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
    }
    
    if ([self versionTabBarSelectedAtIndex:sender.tag - 100]) {
        self.selectedIndex = sender.tag - 100;
    } else {
        sender.selected = NO;
        sender.userInteractionEnabled = YES;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.hidesBottomBarWhenPushed) {
        self.bgImageView.hidden = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.tabBar.hidden = YES;
    if (!viewController.hidesBottomBarWhenPushed) {
        self.bgImageView.hidden = NO;
    }
}

#pragma mark - Getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, kScreenHeight - kTabBarHeight, kScreenWidth, kTabBarHeight);
        imageView.image = kIMAGE(@"tabbar_bg");
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (NSArray *)vcIdentifierArray {
    if (!_vcIdentifierArray) {
        _vcIdentifierArray = @[kStoryBoardFind, kStoryBoardSubScribe, kStoryBoardPlay, kStoryBoardDownLoad, kStoryBoardMine];
    }
    return _vcIdentifierArray;
}

- (NSMutableArray *)selectedImageArray {
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray arrayWithArray:@[
            kIMAGE(@"tabbar_find_h"),
            kIMAGE(@"tabbar_sound_h"),
            kIMAGE(@"tabbar_np_playnon"),
            kIMAGE(@"tabbar_download_h"),
            kIMAGE(@"tabbar_me_h"),
        ]];
    }
    return _selectedImageArray;
}

- (NSMutableArray *)normalImageArray {
    if (!_normalImageArray) {
        _normalImageArray = [NSMutableArray arrayWithArray:@[
            kIMAGE(@"tabbar_find_n"),
            kIMAGE(@"tabbar_sound_n"),
            kIMAGE(@"tabbar_np_playnon"),
            kIMAGE(@"tabbar_download_n"),
            kIMAGE(@"tabbar_me_n"),
        ]];
    }
    return _normalImageArray;
}

@end
