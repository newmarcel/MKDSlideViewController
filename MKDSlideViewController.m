//
//  MKDSlideViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011-2013 Marcel Dierkes. All rights reserved.
//

#import "MKDSlideViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+MKDSlideViewController.h"

typedef NS_ENUM(NSInteger, MKDSlideViewControllerPositionType) {
    MKDSlideViewControllerPositionLeft = -1,
    MKDSlideViewControllerPositionCenter = 0,
    MKDSlideViewControllerPositionRight = 1,
};

@interface UIViewController (MKDSlideViewControllerPrivate)
@property (nonatomic, retain, readwrite) MKDSlideViewController * slideViewController;
@end


@interface MKDSlideViewController ()
@property (nonatomic, assign) MKDSlideViewControllerPositionType slidePosition;

@property (nonatomic, retain) UIView * leftPanelView;
@property (nonatomic, retain) UIView * mainPanelView;
@property (nonatomic, retain) UIView * rightPanelView;

@property (nonatomic, retain) UIPanGestureRecognizer * panGestureRecognizer;
@property (nonatomic, retain) UIView * tapOverlayView;

@property (nonatomic, assign) CGPoint previousLocationInView;

@end

@implementation MKDSlideViewController

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController;
{
    self = [super initWithNibName:nil bundle:nil];
    if( self )
    {
        self.mainViewController = mainViewController;
        
        // Setup defaults
        _slidePosition = MKDSlideViewControllerPositionCenter;
        _handleStatusBarStyleChanges = YES;
        _mainStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
        _leftStatusBarStyle = UIStatusBarStyleBlackOpaque;
        _rightStatusBarStyle = UIStatusBarStyleBlackOpaque;
        _slideSpeed = 0.3f;
        _overlapWidth = 52.0f;
    }
    return self;
}

- (void)dealloc
{
    [_leftPanelView release];
    [_rightPanelView release];
    [_mainPanelView release];
    
    [_tapOverlayView release];
    
    [_leftViewController release];
    [_rightViewController release];
    [_mainViewController release];
    
    [super dealloc];
}

// Create the view hierarchy
- (void)loadView
{
    UIView * view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = [UIColor blackColor];
    
    // Setup Panels
    _leftPanelView = [[UIView alloc] initWithFrame:view.bounds];
    _leftPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _leftPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_leftPanelView];
    
    _rightPanelView = [[UIView alloc] initWithFrame:view.bounds];
    _rightPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _rightPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_rightPanelView];
    
    _mainPanelView = [[UIView alloc] initWithFrame:view.bounds];
    _mainPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _mainPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_mainPanelView];
    [_mainPanelView addGestureRecognizer:self.panGestureRecognizer];
    
    // Setup main layer shadow
    CALayer * layer = _mainPanelView.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    layer.shadowOpacity = 0.9f;
    CGRect rect = CGRectInset(_mainPanelView.bounds, 0.0f, -40.0f); // negative inset for an even shadow
    CGPathRef path = [UIBezierPath bezierPathWithRect:rect].CGPath;
    layer.shadowPath = path;
    layer.shadowRadius = 20.0f;
    
    if( self.mainViewController.view.superview == nil )
    {
        self.mainViewController.view.frame = self.mainPanelView.bounds;
        [self.mainPanelView addSubview:self.mainViewController.view];
    }
    if( self.leftViewController.view.superview == nil )
    {
        self.leftViewController.view.frame = self.leftPanelView.bounds;
        [self.leftPanelView addSubview:self.leftViewController.view];
    }
    if( self.rightViewController.view.superview == nil )
    {
        self.rightViewController.view.frame = self.rightPanelView.bounds;
        [self.rightPanelView addSubview:self.rightViewController.view];
    }
    
    self.view = view;
    [view release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if( [self.view window] == nil )
    {
        self.delegate = nil;
    }
}

#pragma mark - Child View Controllers

- (void)setMainViewController:(UIViewController *)mainViewController
{
    if( _mainViewController != nil )
    {
        // Clean up
        [_mainViewController removeFromParentViewController];
        _mainViewController.slideViewController = nil;
        [_mainViewController.view removeFromSuperview];
        [_mainViewController release];
    }
    _mainViewController = [mainViewController retain];
    _mainViewController.slideViewController = self;
    [self addChildViewController:_mainViewController];
    
    if( _mainPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.mainViewController.view.frame = self.mainPanelView.bounds;
        [self.mainPanelView addSubview:self.mainViewController.view];
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if( _leftViewController != nil )
    {
        // Clean up
        [_leftViewController removeFromParentViewController];
        _leftViewController.slideViewController = nil;
        [_leftViewController.view removeFromSuperview];
        [_leftViewController release];
    }
    _leftViewController = [leftViewController retain];
    _leftViewController.slideViewController = self;
    [self addChildViewController:_leftViewController];
    
    if( _leftPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.leftViewController.view.frame = self.leftPanelView.bounds;
        [self.leftPanelView addSubview:self.leftViewController.view];
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    if( _rightViewController != nil )
    {
        // Clean up
        [_rightViewController removeFromParentViewController];
        _rightViewController.slideViewController = nil;
        [_rightViewController.view removeFromSuperview];
        [_rightViewController release];
    }
    _rightViewController = [rightViewController retain];
    _rightViewController.slideViewController = self;
    [self addChildViewController:_rightViewController];
    
    if( _rightPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.rightViewController.view.frame = self.rightPanelView.bounds;
        [self.rightPanelView addSubview:self.rightViewController.view];
    }
}

- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated
{
    if(!animated)
    {
        self.mainViewController = mainViewController;
        [self showMainViewControllerAnimated:animated];
        return;
    }
    
    if( self.mainViewController != nil )
    {
        // Slide out of sight
        CGRect initialFrame = self.mainPanelView.bounds;
        CGRect frame = initialFrame;
        frame.origin.x = frame.size.width + self.overlapWidth;
        
        [UIView animateWithDuration:self.slideSpeed
                         animations:^{
                             self.mainPanelView.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             // Replace the view controller and slide back in
                             self.mainViewController = mainViewController;
                             [self showMainViewControllerAnimated:animated];
                         }
         ];
    }
}

#pragma mark - Rotation Handling

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Panning

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if( _panGestureRecognizer == nil )
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        _panGestureRecognizer.maximumNumberOfTouches = 1;
    }
    return _panGestureRecognizer;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if( gesture.state == UIGestureRecognizerStateBegan )
    {
        self.previousLocationInView = CGPointZero;
        
        if( [self isHandlingStatusBarStyleChanges] )
            [[UIApplication sharedApplication] setStatusBarStyle:self.leftStatusBarStyle animated:YES];
    }
    else if( gesture.state == UIGestureRecognizerStateChanged )
    {
        // Decide, which view controller should be revealed
        if( self.mainPanelView.frame.origin.x <= 0.0f ) // left
            [self.view sendSubviewToBack:self.leftPanelView];
        else
            [self.view sendSubviewToBack:self.rightPanelView];
        
        // Calculate position offset
        CGPoint locationInView = [gesture translationInView:self.view];
        CGFloat deltaX = locationInView.x - self.previousLocationInView.x;
        
        // Update view frame
        CGRect newFrame = self.mainPanelView.frame;
        newFrame.origin.x +=deltaX;
        self.mainPanelView.frame = newFrame;
        
        self.previousLocationInView = locationInView;
    }
    else if( (gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled) )
    {
        [self updatePanelsForCurrentPosition];
    }
}

- (void)updatePanelsForCurrentPosition
{
    UIApplication * app = [UIApplication sharedApplication];
    
    MKDSlideViewControllerPositionType position = self.slidePosition;
    CGFloat xOffset = self.mainPanelView.frame.origin.x;
    CGFloat snapThreshold = self.overlapWidth;
    
    CGFloat dividerPosition = 0.0f;
    
    if( position == MKDSlideViewControllerPositionCenter )
    {
        if( (xOffset >= (dividerPosition-snapThreshold)) && (xOffset <= (dividerPosition+snapThreshold)) )
        {
            // Snap to center position
            [self showMainViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        else if( xOffset < (dividerPosition-snapThreshold) )
        {
            // snap to right position
            [self showRightViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.rightStatusBarStyle animated:YES];
        }
        else
        {
            // snap to left position
            [self showLeftViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }

    }
    else if( position == MKDSlideViewControllerPositionLeft )
    {
        dividerPosition = self.view.bounds.size.width - self.overlapWidth;
        
        if( (xOffset >= (dividerPosition-snapThreshold)) && (xOffset <= (dividerPosition+snapThreshold)) )
        {
            // Snap back to left position
            [self showLeftViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }
        else if( xOffset < (dividerPosition-snapThreshold) )
        {
            // snap to center position
            [self showMainViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        
    }
    else if( position == MKDSlideViewControllerPositionRight )
    {
        dividerPosition = self.overlapWidth;
        CGFloat rightSideX = xOffset+self.mainPanelView.frame.size.width;
        
        if( (rightSideX <= dividerPosition) && (rightSideX < (dividerPosition+snapThreshold)) ) // FIXME: Is a bit buggy.
        {
            // snap to right position
            [self showRightViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.rightStatusBarStyle animated:YES];
        }
        else
        {
            // snap to center position
            [self showMainViewControllerAnimated:YES];
            if( [self isHandlingStatusBarStyleChanges] )
                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        
    }
    
    self.previousLocationInView = CGPointZero;
}

#pragma mark - Tap Overlay View Handling

- (UIView *)tapOverlayView
{
    if( _tapOverlayView == nil )
    {
        _tapOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _tapOverlayView.backgroundColor = [UIColor clearColor];
        _tapOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainViewController)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_tapOverlayView addGestureRecognizer:tapGesture];
        [tapGesture release];
    }
    return _tapOverlayView;
}

- (void)addTapViewOverlay
{
    [self.mainPanelView addSubview:self.tapOverlayView];
}

- (void)removeTapViewOverlay
{
    [self.tapOverlayView removeFromSuperview];
}

#pragma mark - Slide Actions

- (void)showLeftViewController
{
    [self showLeftViewControllerAnimated:YES];
}

- (void)showLeftViewControllerAnimated:(BOOL)animated
{
    self.slidePosition = MKDSlideViewControllerPositionLeft;
    
    if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
        [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.leftViewController];
    
    if( [self isHandlingStatusBarStyleChanges] )
        [[UIApplication sharedApplication] setStatusBarStyle:self.leftStatusBarStyle animated:YES];
    
    [self.view sendSubviewToBack:self.rightPanelView];
    
    if( animated )
    {
        [UIView animateWithDuration:self.slideSpeed animations:^{
            CGRect theFrame = self.mainPanelView.frame;
            theFrame.origin.x = theFrame.size.width - self.overlapWidth;
            self.mainPanelView.frame = theFrame;
        } completion:^(BOOL finished) {
            [self addTapViewOverlay];
            
            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.leftViewController];
        }];
    }
    else
    {
        CGRect theFrame = self.mainPanelView.frame;
        theFrame.origin.x = theFrame.size.width - self.overlapWidth;
        self.mainPanelView.frame = theFrame;
        [self addTapViewOverlay];
        
        if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
            [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.leftViewController];
    }

}

- (void)showRightViewController
{
    [self showRightViewControllerAnimated:YES];
}

- (void)showRightViewControllerAnimated:(BOOL)animated
{
    self.slidePosition = MKDSlideViewControllerPositionRight;
    
    if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
        [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.rightViewController];
    
    if( [self isHandlingStatusBarStyleChanges] )
        [[UIApplication sharedApplication] setStatusBarStyle:self.rightStatusBarStyle animated:YES];
    
    [self.view sendSubviewToBack:self.leftPanelView];
    
    if( animated )
    {
        [UIView animateWithDuration:self.slideSpeed animations:^{
            CGRect theFrame = self.mainPanelView.frame;
            theFrame.origin.x = -theFrame.size.width + self.overlapWidth;
            self.mainPanelView.frame = theFrame;
        } completion:^(BOOL finished) {
            [self addTapViewOverlay];
            
            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.rightViewController];
        }];
    }
    else
    {
        CGRect theFrame = self.mainPanelView.frame;
        theFrame.origin.x = -theFrame.size.width + self.overlapWidth;
        self.mainPanelView.frame = theFrame;
        [self addTapViewOverlay];
        
        if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
            [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.rightViewController];
    }

}

- (void)showMainViewController
{
    [self showMainViewControllerAnimated:YES];
}

- (void)showMainViewControllerAnimated:(BOOL)animated
{
    self.slidePosition = MKDSlideViewControllerPositionCenter;
    
    if( [self isHandlingStatusBarStyleChanges] )
        [[UIApplication sharedApplication] setStatusBarStyle:self.mainStatusBarStyle animated:YES];
    
    if( self.mainPanelView.frame.origin.x != CGPointZero.x )
    {
        if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
            [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.mainViewController];
        
        if( animated )
        {
            [UIView animateWithDuration:self.slideSpeed animations:^{
                CGRect theFrame = self.mainPanelView.frame;
                theFrame.origin = CGPointZero;
                self.mainPanelView.frame = theFrame;
            } completion:^(BOOL finished) {
                [self removeTapViewOverlay];
                
                if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                    [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
            }];
        }
        else
        {
            CGRect theFrame = self.mainPanelView.frame;
            theFrame.origin = CGPointZero;
            self.mainPanelView.frame = theFrame;
            [self removeTapViewOverlay];
            
            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
        }
        
    }
}

@end
