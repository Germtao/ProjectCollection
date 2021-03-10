//
//  TTBaseViewModel.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTBaseViewModel.h"

@interface TTBaseViewModel ()

@property (nonatomic, strong) RACSubject *updateContentSignal;

@end

@implementation TTBaseViewModel

- (instancetype)initWithRACSubjectName:(NSString *)name {
    if (self = [super init]) {
        self.updateContentSignal = [[RACSubject subject] setNameWithFormat:@"%@", name];
    }
    return self;
}

- (void)refreshDataSource {}

- (NSInteger)numberOfSections { return 0; }

- (NSInteger)numberOfRowsInSection:(NSInteger)section { return 0; }

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath { return 0; }

@end
