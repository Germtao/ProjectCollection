//
//  TTVideoPlayer.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import "TTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface TTVideoPlayer ()

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation TTVideoPlayer

#pragma mark - public

+ (instancetype)player {
    static TTVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[TTVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    // 首先，停止播放
    [self _stopPlay];
    
    NSURL *videoURL = [NSURL URLWithString:videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    // 监听视频资源状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听视频缓冲进度
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 需要在状态变化后，获取时间
    CMTime duration = self.playerItem.duration;
    __unused CGFloat videoDuration = CMTimeGetSeconds(duration);
    
    // 创建播放器
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    // 监听播放器播放进度
    [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度: %@", @(CMTimeGetSeconds(time)));
    }];
    
    // 展示 player layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.playerLayer.frame = attachView.bounds;
    
    [attachView.layer addSublayer:self.playerLayer];
    
    // 监听播放完成 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handlePlayEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            // 在合适的时机，开始播放
            [self.avPlayer play];
        } else {
            // 监听错误
            NSLog(@"播放错误...");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        // 缓冲进度监听
        NSLog(@"缓冲: %@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

#pragma mark - private methods

- (void)_stopPlay {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    // 销毁播放器
    [self.playerLayer removeFromSuperlayer];
    self.playerItem = nil;
    self.avPlayer = nil;
}

- (void)_handlePlayEnd {
    // 播放完成后，循环播放
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer play];
}

@end
