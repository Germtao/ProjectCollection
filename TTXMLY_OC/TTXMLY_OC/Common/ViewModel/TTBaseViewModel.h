//
//  TTBaseViewModel.h
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseViewModel : NSObject

/// 更新数据的信号量
@property (nonatomic, readonly) RACSignal *updateContentSignal;

- (instancetype)initWithRACSubjectName:(NSString *)name;

- (void)refreshDataSource;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
