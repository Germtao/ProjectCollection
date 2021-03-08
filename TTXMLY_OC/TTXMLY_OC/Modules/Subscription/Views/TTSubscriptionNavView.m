//
//  TTSubscriptionNavView.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTSubscriptionNavView.h"
#import <Masonry/Masonry.h>

#define kTitleColorNormal [UIColor colorWithRed:0.40f green:0.40f blue:0.41f alpha:1.00f]
#define kTitleColorSelect [UIColor colorWithRed:0.86f green:0.39f blue:0.30f alpha:1.00f]

@interface TTSubscriptionNavView ()

@property (nonatomic, weak) UIView *sliderView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation TTSubscriptionNavView

+ (instancetype)navViewWithTitles:(NSArray *)titles {
    TTSubscriptionNavView *navView = [[TTSubscriptionNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    navView.titleArray = titles;
    return navView;
}

// MARK: - Public

- (void)transformToControllerAtIndex:(NSInteger)index {
    UIButton *btn = (UIButton *)[self viewWithTag:index + 100];
    btn.selected = YES;
    [self unselectedAllButton:btn];
    [self sliderViewWithAnimation:btn];
}

// MARK: - Private

- (void)makeUI {
    if (_titleArray.count == 0) {
        return;
    }
    
    self.btnArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        NSString *title = _titleArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kTitleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateSelected];
        [btn setTitleColor:kTitleColorSelect forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn setTitle:title forState:UIControlStateNormal];
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
}

/// 将除了当前按钮之外的所有按钮置为非选中状态
- (void)unselectedAllButton:(UIButton *)btn {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]] && btn != obj) {
            ((UIButton *)obj).selected = NO;
        }
    }];
}

- (void)sliderViewWithAnimation:(UIButton *)btn {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.sliderView.frame;
        frame.origin.x = btn.frame.origin.x + 2;
        self.sliderView.frame = frame;
    }];
}

// MARK: - Action

- (void)btnSelected:(UIButton *)sender {
    sender.selected = YES;
    [self unselectedAllButton:sender];
    [self sliderViewWithAnimation:sender];
    
    if (self.navViewDidClicked) {
        self.navViewDidClicked(self, sender.tag - 100);
    }
}

// MARK: - Setter

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self makeUI];
    [self sliderView];
}

// MARK: - Getter

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kTitleColorSelect;
        [self addSubview:view];
        _sliderView = view;
    }
    return _sliderView;
}

@end
