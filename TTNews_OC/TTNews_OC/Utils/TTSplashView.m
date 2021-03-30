//
//  TTSplashView.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import "TTSplashView.h"
#import "TTScreen.h"

@interface TTSplashView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *removeBtn;

@end

@implementation TTSplashView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.removeBtn];
        self.removeBtn.frame = UIRect(330, 100, 60, 35);
    }
    return self;
}

- (void)_removeSplashView {
    [self removeFromSuperview];
}

#pragma mark - getter

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeBtn.backgroundColor = [UIColor lightGrayColor];
        [_removeBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"splash"];
    }
    return _imageView;
}

@end
