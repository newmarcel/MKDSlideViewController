//
//  MKDSlideViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>  // Don't forget to add the QuartzCore Framework to your project

#define kSlideSpeed 0.3f
#define kSlideOverlapWidth 44.0f;

@interface MKDSlideViewController : UIViewController

@property (nonatomic, retain) UIViewController * leftViewController;
@property (nonatomic, retain) UIViewController * rightViewController;
@property (nonatomic, retain) UIViewController * rootViewController;

@property (nonatomic, retain) UIBarButtonItem * menuBarButtonItem;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)setLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

- (IBAction)slideToRight:(id)sender;
- (IBAction)slideToLeft:(id)sender;

@end
