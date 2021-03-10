//
//  TTIconButtonView.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import "TTFindHotGuessModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTIconButtonView : UIView

@property (nonatomic, strong) TTFindDiscoverDetailModel *detailModel;

+ (instancetype)iconButtonView;

- (void)configWithTitle:(NSString *)title localImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
