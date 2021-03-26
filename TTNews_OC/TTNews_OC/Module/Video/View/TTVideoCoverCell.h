//
//  TTVideoCoverCell.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTVideoCoverCell : UICollectionViewCell

- (void)layoutWithVideoUrl:(NSString *)videoUrl videoCover:(NSString *)videoCover;

@end

NS_ASSUME_NONNULL_END
