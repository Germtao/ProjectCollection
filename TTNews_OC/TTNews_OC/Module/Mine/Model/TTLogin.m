//
//  TTLogin.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import "TTLogin.h"
//#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface TTLogin () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oAuth;
@property (nonatomic, copy) TTLoginFinishBlock finishBlock;
@property (nonatomic, assign) BOOL isLogin;

@end

@implementation TTLogin

+ (instancetype)sharedLogin {
    static TTLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[TTLogin alloc] init];
    });
    return login;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oAuth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    }
    return self;
}

#pragma mark - 登录

- (BOOL)isLogin {
    // 登录状态失效的逻辑
    return _isLogin;
}

- (void)loginWithFinishBlock:(TTLoginFinishBlock)finishBlock {
    _finishBlock = [finishBlock copy];
    
    _oAuth.authMode = kAuthModeClientSideToken;
    [_oAuth authorize:@[kOPEN_PERMISSION_GET_USER_INFO,
                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                        kOPEN_PERMISSION_ADD_ALBUM,
                        kOPEN_PERMISSION_ADD_TOPIC,
                        kOPEN_PERMISSION_CHECK_PAGE_FANS,
                        kOPEN_PERMISSION_GET_INFO,
                        kOPEN_PERMISSION_GET_OTHER_INFO,
                        kOPEN_PERMISSION_LIST_ALBUM,
                        kOPEN_PERMISSION_UPLOAD_PIC,
                        kOPEN_PERMISSION_GET_VIP_INFO,
                        kOPEN_PERMISSION_GET_VIP_RICH_INFO]];
}

- (void)logout {
    [_oAuth logout:self];
    _isLogin = NO;
}

#pragma mark - 分享

- (void)shareToQQWithArticleURL:(NSURL *)articleURL {
    // 登陆校验
    // loginWithFinishBlock
    
    QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:articleURL title:@"iOS" description:@"从0开始iOS开发" previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObject];
    __unused QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req];
}

#pragma mark - TencentLoginDelegate

- (void)tencentDidLogin {
    _isLogin = YES;
    // 保存 openId
    [_oAuth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

- (void)tencentDidNotNetWork {
    // 登录时网络有问题的回调
}

#pragma mark - TencentSessionDelegate

- (void)tencentDidLogout {
    // 退出登录，需要清理下存储在本地的登录数据
}

/// 获取用户个人信息回调
- (void)getUserInfoResponse:(APIResponse*)response {
    NSDictionary *userInfo = response.jsonResponse;
    _nickname = userInfo[@"nickname"];
    _address = userInfo[@"city"];
    _avatarUrl = userInfo[@"figureurl_qq_2"];
    
    if (_finishBlock) {
        _finishBlock(YES);
    }
}

@end
