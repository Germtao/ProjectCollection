//
//  TTLogin.h
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TTLoginFinishBlock)(BOOL isLogin);

@interface TTLogin : NSObject

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *avatarUrl;

+ (instancetype)sharedLogin;

#pragma mark - 登录

@property (nonatomic, assign, readonly) BOOL isLogin;
- (void)loginWithFinishBlock:(TTLoginFinishBlock)finishBlock;
- (void)logout;

#pragma mark - 分享

- (void)shareToQQWithArticleURL:(NSURL *)articleURL;

@end

NS_ASSUME_NONNULL_END
