//
//  AppDelegate.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    Log(@"did Finish Launching With Options. 开始执行");
    [[TTStopWatchTool sharedInstance] splitWithDescription:@"did finish launch."];
    Log(@"did Finish Launching With Options. 执行完毕");
    return YES;
}


#pragma mark - UISceneSession lifecycle

/// 1. 如果没有在 APP 的 Info.plist 文件中包含scene的配置数据，或者要动态更改场景配置数据，需要实现此方法。
/// UIKit 会在创建新 scene 前调用此方法。
/// 参数 options 是一个 UISceneConnectionOptions 类，
/// 官方解释：它包含了为什么要创建一个新的 scene 的信息。根据参数信息判断是否要创建一个新的 scene
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    Log(@"1111111111xxxxxxxxxxxxx");
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

/// 方法会返回一个 UISceneConfiguration 对象，其包含其中包含场景详细信息，包括要创建的场景类型，
/// 用于管理场景的委托对象以及包含要显示的初始视图控制器的情节提要。
/// 如果未实现此方法，则必须在应用程序的 Info.plist 文件中提供场景配置数据。
/// 总结下：默认在 Info.plist 中进行了配置，不用实现该方法也没有关系。
/// 如果没有配置就需要实现这个方法并返回一个 UISceneConfiguration 对象。
/// 在分屏中关闭其中一个或多个 scene 时候回调用。
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    Log(@"222222222xxxxxxxxxxxxxx");
}


@end
