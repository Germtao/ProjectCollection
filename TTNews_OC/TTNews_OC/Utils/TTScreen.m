//
//  TTScreen.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/29.
//

#import "TTScreen.h"

@implementation TTScreen

/// iPhone xs max、12pro max
+ (CGSize)sizeFor65Inch {
    return CGSizeMake(414, 896);
}

/// iPhone xr、12、12pro
+ (CGSize)sizeFor61Inch {
    return CGSizeMake(414, 896);
}

/// iPhone x
+ (CGSize)sizeFor58Inch {
    return CGSizeMake(375, 812);
}

@end
