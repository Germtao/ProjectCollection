//
//  TTBasePlayView.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBasePlayView : UIView

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UIImageView *bgImageView;

@property (nonatomic, copy) void(^playButtonClicked)(UIButton *btn);

- (void)startPlay;

- (void)stopPlay;

@end

NS_ASSUME_NONNULL_END
