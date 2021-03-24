//
//  ViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "ViewController.h"
#import "TTListLoader.h"

@interface ViewController ()

@property (nonatomic, strong) TTListLoader *listLoader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listLoader = [[TTListLoader alloc] init];
    [self.listLoader loadListData];
}


@end
