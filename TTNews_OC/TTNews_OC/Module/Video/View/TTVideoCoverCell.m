//
//  TTVideoCoverCell.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import "TTVideoCoverCell.h"
#import "TTVideoToolBar.h"
#import "TTVideoPlayer.h"

@interface TTVideoCoverCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *playButton;
@property (nonatomic, strong) TTVideoToolBar *toolBar;

@property (nonatomic, copy) NSString *videoUrl;

@end

@implementation TTVideoCoverCell

#pragma mark - public

- (void)layoutWithVideoUrl:(NSString *)videoUrl videoCover:(NSString *)videoCover {
    self.coverImageView.image = [UIImage imageNamed:videoCover];
    self.videoUrl = videoUrl;
    [self.toolBar layoutWithModel:nil];
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView addSubview:self.playButton];
    [self.contentView addSubview:self.toolBar];
}

- (void)_tapToPlayVideo {
    // 在当前 item 上播放视频
    [[TTVideoPlayer player] playVideoWithUrl:self.videoUrl attachView:self.coverImageView];
}

#pragma mark - getter

- (TTVideoToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[TTVideoToolBar alloc] initWithFrame:CGRectMake(0, self.coverImageView.frame.size.height, self.contentView.frame.size.width, 60)];
    }
    return _toolBar;
}

- (UIImageView *)playButton {
    if (!_playButton) {
        _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width - 50) / 2, (self.contentView.frame.size.height - 60 - 50) / 2, 50, 50)];
        _playButton.image = [UIImage imageNamed:@"videoPlay"];
    }
    return _playButton;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 60)];
        _coverImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlayVideo)];
        [_coverImageView addGestureRecognizer:tapGesture];
    }
    return _coverImageView;
}

@end
