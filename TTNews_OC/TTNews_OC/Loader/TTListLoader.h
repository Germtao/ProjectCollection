//
//  TTListLoader.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import <Foundation/Foundation.h>

@class TTListItem;

typedef void(^TTListLoaderFinishBlock)(BOOL success, NSArray<TTListItem *> * _Nonnull dataArray);

NS_ASSUME_NONNULL_BEGIN

/// 列表数据请求
@interface TTListLoader : NSObject

- (void)loadListDataWithFinishBlock:(TTListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
