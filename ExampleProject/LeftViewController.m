//
//  LeftViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 18.04.13.
//
//

#import "LeftViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "MainViewController.h"
#import "SecondaryViewController.h"

@implementation LeftViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
    if( row == 0 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[MainViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self.navigationController.slideViewController setMainViewController:mainViewController animated:YES];
        }
    }
    else if( row == 1 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[SecondaryViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * secondaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondaryViewController"];
            [self.navigationController.slideViewController setMainViewController:secondaryViewController animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
