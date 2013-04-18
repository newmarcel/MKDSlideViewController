//
//  AppDelegate.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MKDSlideViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_slideViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    UIViewController * mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    UIViewController * leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    UIViewController * rightViewController = [storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    _slideViewController = [[MKDSlideViewController alloc] initWithMainViewController:mainViewController];
    _slideViewController.leftViewController = leftViewController;
    _slideViewController.rightViewController = rightViewController;
    
    self.window.rootViewController = self.slideViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
