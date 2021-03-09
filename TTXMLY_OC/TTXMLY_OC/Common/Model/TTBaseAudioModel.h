//
//  TTBaseAudioModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseAudioModel : TTBaseModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger album_id;
@property (nonatomic, assign) NSInteger track_id;
@property (nonatomic, copy)   NSString  *album_title;
@property (nonatomic, copy)   NSString  *track_title;
@property (nonatomic, copy)   NSString  *coverSmall;
@property (nonatomic, assign) NSInteger time_history;
@property (nonatomic, assign) NSInteger isPlaying;
@property (nonatomic, copy)   NSString  *cachePath;

@end

NS_ASSUME_NONNULL_END
