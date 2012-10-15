//
//  MainViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "SecondLevelViewController.h"

@implementation MainViewController

@synthesize textView = _textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Main View Controller";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap
{
    SecondLevelViewController * sl = [[SecondLevelViewController alloc] initWithNibName:@"SecondLevelViewController" bundle:nil];
    [self.navigationController pushViewController:sl animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.textView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"Rotate Main View Controller?");
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (void)setDetailText:(NSString *)detailText
{
    self.textView.text = detailText;
}

@end
