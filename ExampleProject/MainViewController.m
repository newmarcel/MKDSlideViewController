//
//  MainViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 Marcel Dierkes. All rights reserved.
//

#import "MainViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"

@implementation MainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // You are now responsible for your own menu button
    UIBarButtonItem * menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"]
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    [menuItem release];
}

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if( [self.view window] == nil )
    {
        self.textView = nil;
    }
}

#pragma mark -

- (void)setDetailText:(NSString *)detailText
{
    self.textView.text = detailText;
}

@end
