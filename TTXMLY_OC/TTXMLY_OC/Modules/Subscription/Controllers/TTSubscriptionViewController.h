//
//  TTSubscriptionViewController.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTBaseViewController.h"
#import "TTSubscriptionFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSubscriptionViewController : TTBaseViewController

+ (instancetype)subscriptionVcWithStyle:(TTSubscriptionStyle)style;

@end

NS_ASSUME_NONNULL_END
