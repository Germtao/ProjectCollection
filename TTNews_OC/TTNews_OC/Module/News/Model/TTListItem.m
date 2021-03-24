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

@end
