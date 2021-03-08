//
//  TTSubscriptionNavView.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <UIKit/UIKit.h>

@class TTSubscriptionNavView;
typedef void(^TTSubscriptionNavViewDidClicked)(TTSubscriptionNavView * _Nonnull navView, NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface TTSubscriptionNavView : UIView

@property (nonatomic, copy) TTSubscriptionNavViewDidClicked navViewDidClicked;

+ (instancetype)navViewWithTitles:(NSArray *)titles;

- (void)transformToControllerAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
