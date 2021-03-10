//
//  TTFindRecommendViewModel.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/9.
//

#import "TTFindRecommendViewModel.h"
#import "TTFindRecommendModel.h"
#import "TTFindLiveModel.h"
#import "TTFindHotGuessModel.h"
#import "TTFindApi.h"

@implementation TTFindRecommendViewModel

- (NSInteger)numberOfSections {
    return 8;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case TTFindRecommendSection_Recommend:
            return 1;
        case TTFindRecommendSection_Live:
            return self.liveModel.data.count == 0 ? 0 : 1;
        case TTFindRecommendSection_GuessULike:
            return self.hotGuessModel.guess.list.count == 0 ? 0 : 1;
        case TTFindRecommendSection_CityColumn:
            return self.hotGuessModel.cityColumn.list.count == 0 ? 0 : 1;
        case TTFindRecommendSection_Special:
            return self.recommendModel.specialColumn.list.count == 0 ? 0 : 1;
        case TTFindRecommendSection_Advertise:
            return 0;
        case TTFindRecommendSection_Hot:
            return self.hotGuessModel.hotRecommends.list.count;
        case TTFindRecommendSection_More:
            return 1;
        default:
            return 0;
    }
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case TTFindRecommendSection_Recommend:
            return 230.0;
        case TTFindRecommendSection_Live:
            return self.liveModel.data.count == 0 ? 0 : 227.0;
        case TTFindRecommendSection_GuessULike:
            return self.hotGuessModel.guess.list.count == 0 ? 0 : 230.0;
        case TTFindRecommendSection_CityColumn:
            return self.hotGuessModel.cityColumn.list.count == 0 ? 0 : 230.0;
        case TTFindRecommendSection_Special:
            return self.recommendModel.specialColumn.list.count == 0 ? 0 : 219.0;
        case TTFindRecommendSection_Advertise:
            return 0;
        case TTFindRecommendSection_Hot:
            return 230.0;
        case TTFindRecommendSection_More:
            return 60.0;
        default:
            return 0;
    }
}

- (void)refreshDataSource {
    @weakify(self);
    RACSignal *signalRecommend = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestRecommendList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalHotGuess = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestHotGuessList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalLive = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestLiveList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    [[RACSignal combineLatest:@[signalRecommend, signalHotGuess, signalLive]] subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *)self.updateContentSignal sendNext:nil];
    }];
}

#pragma mark - Private

/// 请求推荐数据
/// @param completion 完成回调
- (void)requestRecommendList:(void(^)(void))completion {
    [TTFindApi requestRecommends:^(id  _Nullable response, NSString * _Nullable message, BOOL success) {
        Log(@"%@", response);
        if (success) {
            self.recommendModel = [TTFindRecommendModel mj_objectWithKeyValues:response];
        }
        
        if (completion) {
            completion();
        }
    }];
}

/// 请求热门和猜你数据
/// @param completion 回调
- (void)requestHotGuessList:(void(^)(void))completion {
    [TTFindApi requestHotAndGuess:^(id  _Nullable response, NSString * _Nullable message, BOOL success) {
        Log(@"%@", response);
        if (success) {
            self.hotGuessModel = [TTFindHotGuessModel mj_objectWithKeyValues:response];
        }
        completion();
    }];
}

- (void)requestLiveList:(void(^)(void))completion {
    [TTFindApi requestLiveRecommend:^(id  _Nullable response, NSString * _Nullable message, BOOL success) {
        Log(@"%@", response);
        if (success) {
            self.liveModel = [TTFindLiveModel mj_objectWithKeyValues:response];
        }
        completion();
    }];
}

@end
