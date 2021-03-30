//
//  SceneDelegate.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "SceneDelegate.h"
#import "TTNewsViewController.h"
#import "TTVideoViewController.h"
#import "TTSplashView.h"

@interface SceneDelegate ()

@property (nonatomic, strong) TTSplashView *splashView;

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)) {
    NSLog(@"场景加载完成");
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = [UIScreen mainScreen].bounds;
        
        UITabBarController *tabBarVC = [[UITabBarController alloc] init];
        
        TTNewsViewController *newsVC = [[TTNewsViewController alloc] init];
        TTVideoViewController *videoVC = [[TTVideoViewController alloc] init];
        
        tabBarVC.viewControllers = @[newsVC, videoVC];
        
        UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
        
        [self.window addSubview:self.splashView];
        
    } else {
        // Fallback on earlier versions
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    NSLog(@"场景已经断开连接");
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    NSLog(@"已经从后台进入前台");
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"即将从前台进入后台");
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"即将从后台进入前台");
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    NSLog(@"已经从前台进入后台");
}

- (TTSplashView *)splashView {
    if (!_splashView) {
        _splashView = [[TTSplashView alloc] initWithFrame:self.window.bounds];
    }
    return _splashView;
}

@end
