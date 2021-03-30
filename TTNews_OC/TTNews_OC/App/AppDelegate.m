//
//  AppDelegate.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "AppDelegate.h"
#import "TTNewsViewController.h"
#import "TTVideoViewController.h"
#import "TTSplashView.h"

@interface AppDelegate ()

@property (nonatomic, strong) TTSplashView *splashView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 13.0, *)) {
        
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITabBarController *tabBarVC = [[UITabBarController alloc] init];
        
        TTNewsViewController *newsVC = [[TTNewsViewController alloc] init];
        TTVideoViewController *videoVC = [[TTVideoViewController alloc] init];
        
        tabBarVC.viewControllers = @[newsVC, videoVC];
        
        UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
        
        [self.window addSubview:self.splashView];
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    NSLog(@"0");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"1");
}

- (TTSplashView *)splashView {
    if (!_splashView) {
        _splashView = [[TTSplashView alloc] initWithFrame:self.window.bounds];
    }
    return _splashView;
}

@end
