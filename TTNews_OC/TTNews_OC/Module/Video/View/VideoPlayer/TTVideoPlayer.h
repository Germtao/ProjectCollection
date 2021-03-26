//
//  TTVideoPlayer.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTVideoPlayer : NSObject

+ (instancetype)player;

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
