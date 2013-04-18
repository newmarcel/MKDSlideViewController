//
//  UIViewController+MKDSlideViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 16.04.13.
//
//

#import "UIViewController+MKDSlideViewController.h"
#import <objc/runtime.h>
#import "MKDSlideViewController.h"

@implementation UIViewController (MKDSlideViewController)
@dynamic slideViewController;

static void * kSlideViewControllerKey;

- (MKDSlideViewController *)slideViewController
{
    return objc_getAssociatedObject(self, kSlideViewControllerKey);
}

- (void)setSlideViewController:(MKDSlideViewController *)slideViewController
{
    objc_setAssociatedObject(self, kSlideViewControllerKey, slideViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
