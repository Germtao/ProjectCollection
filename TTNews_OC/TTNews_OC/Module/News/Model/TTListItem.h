//
//  TTListItem.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface TTListItem : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *picUrl1;
@property (nonatomic, copy) NSString *picUrl2;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *uniqueKey;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *articleUrl;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
