//
//  main.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    [[TTStopWatchTool sharedInstance] start];
    [[TTStopWatchTool sharedInstance] splitWithDescription:@"main()执行."];
    
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
