//
//  TTVideoToolBar.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import "TTVideoToolBar.h"

@interface TTVideoToolBar ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, strong) UIImageView *shareImageView;
@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) CALayer *bottomLine;

@end

@implementation TTVideoToolBar

#pragma mark - public

- (void)layoutWithModel:(id)model {
    self.avatarImageView.image = [UIImage imageNamed:@"icon"];
    self.nicknameLabel.text = @"极客时间";
    
    self.commentImageView.image = [UIImage imageNamed:@"comment"];
    self.commentLabel.text = @"1000";
    
    self.likeImageView.image = [UIImage imageNamed:@"praise"];
    self.likeLabel.text = @"100";
    
    self.shareImageView.image = [UIImage imageNamed:@"share"];
    self.shareLabel.text = @"分享";
    
    #pragma mark - 系统原生 AutoLayout
    [NSLayoutConstraint activateConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.avatarImageView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0],
        
        [NSLayoutConstraint constraintWithItem:self.avatarImageView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                      constant:15],
        
        [NSLayoutConstraint constraintWithItem:self.avatarImageView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:30],
        
        [NSLayoutConstraint constraintWithItem:self.avatarImageView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1
                                      constant:30],
        
        [NSLayoutConstraint constraintWithItem:self.nicknameLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.avatarImageView
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0],
        
        [NSLayoutConstraint constraintWithItem:self.nicknameLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.avatarImageView
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1
                                      constant:0]
    ]];
    
    #pragma mark - VFL 布局
    NSString *vflString = @"H:|-15-[_avatarImageView]-0-[_nicknameLabel]-(>=0)-[_commentImageView(==_avatarImageView)]-0-[_commentLabel]-15-[_likeImageView(==_avatarImageView)]-0-[_likeLabel]-15-[_shareImageView(==_avatarImageView)]-0-[_shareLabel]-15-|";
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatarImageView, _nicknameLabel, _commentImageView, _commentLabel, _likeImageView, _likeLabel, _shareImageView, _shareLabel)]];
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 观察下View的frame
}

- (void)makeUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.commentImageView];
    [self addSubview:self.commentLabel];
    [self addSubview:self.likeImageView];
    [self addSubview:self.likeLabel];
    [self addSubview:self.shareImageView];
    [self addSubview:self.shareLabel];
    [self.layer addSublayer:self.bottomLine];
}

#pragma mark - getter

- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.font = [UIFont systemFontOfSize:15];
        _shareLabel.textColor = [UIColor lightGrayColor];
        _shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _shareLabel;
}

- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shareImageView.layer.cornerRadius = 15;
        _shareImageView.layer.masksToBounds = YES;
        _shareImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _shareImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shareImageView;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.font = [UIFont systemFontOfSize:15];
        _likeLabel.textColor = [UIColor lightGrayColor];
        _likeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _likeLabel;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _likeImageView.layer.cornerRadius = 15;
        _likeImageView.layer.masksToBounds = YES;
        _likeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _likeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _likeImageView;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:15];
        _commentLabel.textColor = [UIColor lightGrayColor];
        _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _commentLabel;
}

- (UIImageView *)commentImageView {
    if (!_commentImageView) {
        _commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _commentImageView.layer.cornerRadius = 15;
        _commentImageView.layer.masksToBounds = YES;
        _commentImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _commentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _commentImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:15];
        _nicknameLabel.textColor = [UIColor lightGrayColor];
        _nicknameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nicknameLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.layer.cornerRadius = 15;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avatarImageView;
}

- (CALayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[CALayer alloc] init];
        _bottomLine.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
        _bottomLine.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _bottomLine;
}

@end
