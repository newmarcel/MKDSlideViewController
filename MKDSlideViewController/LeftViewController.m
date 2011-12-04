//
//  ViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MKDSlideViewController.h"

@implementation LeftViewController

@synthesize mainViewController = _mainViewController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainViewController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark -

- (IBAction)changeText:(id)sender
{
    MainViewController * main = (MainViewController *)self.mainViewController;
    if( self.mainViewController )
    {
        [main setDetailText:@"Pressed a button…"];
    }
}

- (IBAction)navigateToMainViewController:(id)sender
{
    // Use the application delegate to interact with the Slide View Controller
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    MKDSlideViewController * slideViewController = appDelegate.slideViewController;
    [slideViewController showMainViewController:self];
}

- (IBAction)navigateToRightViewController:(id)sender
{
    // Use the application delegate to interact with the Slide View Controller
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    MKDSlideViewController * slideViewController = appDelegate.slideViewController;
    [slideViewController showRightViewController:self];
}

@end
