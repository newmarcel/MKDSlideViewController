//
//  ViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController

@property (nonatomic, assign) UIViewController * mainViewController;

- (IBAction)changeText:(id)sender;
- (IBAction)navigateToMainViewController:(id)sender;
- (IBAction)navigateToRightViewController:(id)sender;

@end
