//
//  TTNewsViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "TTNewsViewController.h"
#import "TTListLoader.h"

@interface TTNewsViewController ()

@property (nonatomic, strong) TTListLoader *listLoader;

@end

@implementation TTNewsViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listLoader = [[TTListLoader alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<TTListItem *> *dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"");
    }];
}


@end
