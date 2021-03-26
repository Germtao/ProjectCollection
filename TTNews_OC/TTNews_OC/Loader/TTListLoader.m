//
//  TTListLoader.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "TTListLoader.h"
#import <AFNetworking.h>
#import "TTListItem.h"

@implementation TTListLoader

- (void)loadListDataWithFinishBlock:(TTListLoaderFinishBlock)finishBlock {
    
    // 使用 AFNetworking 加载数据
//    [[AFHTTPSessionManager manager] GET:@"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
    
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *listURL = [NSURL URLWithString:urlString];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
#warning 类型检查
        NSArray *dataArray = [(NSDictionary *)[(NSDictionary *)jsonObj objectForKey:@"result"] objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            TTListItem *item = [[TTListItem alloc] init];
            [item configWithDictionary:info];
            [listItemArray addObject:item];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(error == nil, listItemArray);
            }
        });

        NSLog(@"...");
    }];

    [dataTask resume];
    
    [self _getSanBoxPath];
}

- (void)_getSanBoxPath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"");
}

@end
