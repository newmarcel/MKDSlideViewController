//
//  MKDSlideViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011-2013 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKDSlideViewControllerDelegate;

@interface MKDSlideViewController : UIViewController
@property (nonatomic, assign) id<MKDSlideViewControllerDelegate> delegate;

// Child View Controllers
@property (nonatomic, retain) UIViewController * leftViewController;
@property (nonatomic, retain) UIViewController * rightViewController;
@property (nonatomic, retain) UIViewController * mainViewController;

// Status Bar Handling
@property (nonatomic, assign, getter = isHandlingStatusBarStyleChanges) BOOL handleStatusBarStyleChanges;  // default: YES
@property (nonatomic, assign) UIStatusBarStyle mainStatusBarStyle;  // default: application launch status bar style
@property (nonatomic, assign) UIStatusBarStyle leftStatusBarStyle;  // default: UIStatusBarStyleBlackOpaque
@property (nonatomic, assign) UIStatusBarStyle rightStatusBarStyle;  // default: UIStatusBarStyleBlackOpaque

// Behaviour Configuration
@property (nonatomic, assign) CGFloat slideSpeed;  // default: 0.3f
@property (nonatomic, assign) CGFloat overlapWidth;  // default: 52.0f


- (instancetype)initWithMainViewController:(UIViewController *)mainViewController;
- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;  // calls - (void)showMainViewControllerAnimated: on completion


// Display Handling
- (void)showLeftViewController;
- (void)showLeftViewControllerAnimated:(BOOL)animated;

- (void)showRightViewController;
- (void)showRightViewControllerAnimated:(BOOL)animated;

- (void)showMainViewController;
- (void)showMainViewControllerAnimated:(BOOL)animated;

@end


@protocol MKDSlideViewControllerDelegate <NSObject>
@optional
- (void)slideViewController:(MKDSlideViewController *)svc willSlideToViewController:(UIViewController *)vc;
- (void)slideViewController:(MKDSlideViewController *)svc didSlideToViewController:(UIViewController *)vc;
@end
