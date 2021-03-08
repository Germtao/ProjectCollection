//
//  TTFindSubTitleView.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <UIKit/UIKit.h>

@class TTFindSubTitleView;
@protocol TTFindSubTitleViewDelegate <NSObject>

/// 当前选中第 index 个标题
- (void)findSubTitleViewDidSelected:(TTFindSubTitleView *_Nonnull)titleView
                            atIndex:(NSInteger)index
                              title:(NSString *_Nonnull)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TTFindSubTitleView : UIView

@property (nonatomic, strong) NSMutableArray<NSString *> *titleArray;

@property (nonatomic, weak) id <TTFindSubTitleViewDelegate> delegate;

- (void)transform2ShowAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
