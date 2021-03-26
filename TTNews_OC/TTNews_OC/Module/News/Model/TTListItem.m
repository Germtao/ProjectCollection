//
//  TTListItem.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "TTListItem.h"

@implementation TTListItem

- (void)configWithDictionary:(NSDictionary *)dictionary {
#warning 注意类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.title = [dictionary objectForKey:@"title"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.picUrl1 = [dictionary objectForKey:@"thumbnail_pic_s02"];
    self.picUrl2 = [dictionary objectForKey:@"thumbnail_pic_s03"];
    self.date = [dictionary objectForKey:@"date"];
    self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

#pragma mark - 序列化和反序列化 NSSecureCoding

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.picUrl forKey:@"picUrl"];
    [coder encodeObject:self.picUrl1 forKey:@"picUrl1"];
    [coder encodeObject:self.picUrl2 forKey:@"picUrl2"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [coder encodeObject:self.authorName forKey:@"authorName"];
    [coder encodeObject:self.articleUrl forKey:@"articleUrl"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.picUrl = [coder decodeObjectForKey:@"picUrl"];
        self.picUrl1 = [coder decodeObjectForKey:@"picUrl1"];
        self.picUrl2 = [coder decodeObjectForKey:@"picUrl2"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.uniqueKey = [coder decodeObjectForKey:@"uniqueKey"];
        self.authorName = [coder decodeObjectForKey:@"authorName"];
        self.articleUrl = [coder decodeObjectForKey:@"articleUrl"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
