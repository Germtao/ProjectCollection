//
//  TTFindSubTitleView.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTFindSubTitleView.h"
#import <Masonry/Masonry.h>

#define kSystemOriginColor [UIColor colorWithRed:0.96f green:0.39f blue:0.26f alpha:1.00f]
#define kSystemBlackColor  [UIColor colorWithRed:0.38f green:0.39f blue:0.40f alpha:1.00f]

@interface TTFindSubTitleView ()

/// 滑块视图
@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, strong) NSMutableArray *subTitleBtnArray;

@property (nonatomic, strong) UIButton *currentSelectedBtn;

@end

@implementation TTFindSubTitleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// MARK: - Private

/// 对所有按钮颜色执行反选操作
- (void)unselectedAllButton:(UIButton *)btn {
    for (UIButton *subBtn in _subTitleBtnArray) {
        if (subBtn == btn) {
            continue;
        }
        subBtn.selected = NO;
    }
}

- (void)selectedAtButton:(UIButton *)btn isFirstStart:(BOOL)first {
    btn.selected = YES;
    self.currentSelectedBtn = btn;
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(btn.frame.origin.x + btn.frame.size.width / 2 - 15);
    }];
    
    if (!first) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
    [self unselectedAllButton:btn];
}

- (void)configSubTitles {
    CGFloat width = kScreenWidth / _titleArray.count;
    
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        NSString *title = [_titleArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kSystemOriginColor forState:UIControlStateSelected];
        [button setTitleColor:kSystemBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kSystemOriginColor forState:UIControlStateHighlighted | UIControlStateSelected];
        button.frame = CGRectMake(width * i, 0, width, 38);
        button.titleLabel.font = kFont(15);
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(subTitleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTitleBtnArray addObject:button];
        [self addSubview:button];
    }
    
    UIButton *btn = [_subTitleBtnArray firstObject];
    [self selectedAtButton:btn isFirstStart:YES];
}

// MARK: - Action

- (void)subTitleBtnClicked:(UIButton *)sender {
    if (sender == _currentSelectedBtn) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(findSubTitleViewDidSelected:atIndex:title:)]) {
        [self.delegate findSubTitleViewDidSelected:self
                                           atIndex:[_subTitleBtnArray indexOfObject:sender]
                                             title:sender.currentTitle];
    }
    [self selectedAtButton:sender isFirstStart:NO];
}

// MARK: - Setter

- (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    [self configSubTitles];
}

// MARK: - Getter

- (NSMutableArray *)subTitleBtnArray {
    if (!_subTitleBtnArray) {
        _subTitleBtnArray = [NSMutableArray array];
    }
    return _subTitleBtnArray;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSystemOriginColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.bottom.equalTo(self.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(30, 2));
        }];
        _sliderView = view;
    }
    return _sliderView;
}

// MARK: - Public
- (void)transform2ShowAtIndex:(NSInteger)index {
    if (index < 0 || index >= _subTitleBtnArray.count) {
        return;
    }
    
    UIButton *btn = [_subTitleBtnArray objectAtIndex:index];
    [self selectedAtButton:btn isFirstStart:NO];
}

@end
