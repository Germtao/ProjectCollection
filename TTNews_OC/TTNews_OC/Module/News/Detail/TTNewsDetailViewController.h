//
//  TTNewsDetailViewController.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import <UIKit/UIKit.h>
#import "TTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTNewsDetailViewController : UIViewController <TTDetailViewControllerProtocol>

- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
