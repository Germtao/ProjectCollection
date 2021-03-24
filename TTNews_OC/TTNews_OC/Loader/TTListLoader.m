//
//  TTListLoader.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "TTListLoader.h"

@implementation TTListLoader

- (void)loadListData {
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *listURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"...");
    }];
    
    [dataTask resume];
}

@end
