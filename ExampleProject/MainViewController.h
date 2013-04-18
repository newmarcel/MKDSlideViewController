//
//  MainViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITextView * textView;

- (IBAction)showMenu:(id)sender;
- (void)setDetailText:(NSString *)detailText;

@end
