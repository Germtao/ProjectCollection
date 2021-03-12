//
//  TTBasePlayView.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/11.
//

#import "TTBasePlayView.h"
#import <UIImageView+YYWebImage.h>
#import <Masonry.h>

@implementation TTBasePlayView

#pragma mark - public

- (void)startPlay {
    [self.iconView.layer removeAllAnimations];
    
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnim.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotateAnim.duration = 10.f;
    rotateAnim.cumulative = YES;
    rotateAnim.repeatCount = MAXFLOAT;
    
    [self.iconView.layer addAnimation:rotateAnim forKey:@"rotateAnimation"];
}

- (void)stopPlay {
    [self.iconView.layer removeAllAnimations];
}

#pragma mark - action

- (void)playButtonClicked:(UIButton *)sender {
    if (self.playButtonClicked) {
        self.playButtonClicked(sender);
    }
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    
    CGFloat space = (self.width - 48) / 2.0f;
    
    self.iconView.frame = CGRectMake(space, space, 48.0f, 48.0f);
    
    self.playBtn.frame = CGRectMake(space - 2, space - 2, 52.0f, 52.0f);
    
    [self bringSubviewToFront:self.iconView];
    [self bringSubviewToFront:self.playBtn];
}

#pragma mark - getter

- (UIButton *)playBtn {
    if (!_playBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 26.0f;
        btn.layer.masksToBounds = YES;
        [btn setImage:kIMAGE(@"tabbar_np_play") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _playBtn = btn;
    }
    return _playBtn;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kIMAGE(@"tabbar_np_playnon")];
        imageView.layer.cornerRadius = 24.0f;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _iconView = imageView;
    }
    return _iconView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kIMAGE(@"tabbar_np_normal")];
        [self addSubview:imageView];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

@end
