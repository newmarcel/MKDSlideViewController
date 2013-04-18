//
//  SecondaryViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 18.04.13.
//
//

#import "SecondaryViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"

@implementation SecondaryViewController

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

@end
