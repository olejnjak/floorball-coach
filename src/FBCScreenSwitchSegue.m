//
//  FBCScreenSwitchSegue.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCScreenSwitchSegue.h"

@implementation FBCScreenSwitchSegue

- (void)perform
{
    UIViewController *src = self.sourceViewController;
    
    [self prepareDestinationController];
    
    [UIView animateWithDuration:0.3 animations:^{
        [src.view setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self changeViewController];
        [self showDestinationController];
    }];
}

- (void)changeViewController
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    UIWindow *appWindow = src.view.window;
    [appWindow performSelectorOnMainThread:@selector(setRootViewController:)
                                withObject:dst
                             waitUntilDone:NO];
}

- (void)showDestinationController
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    [UIView animateWithDuration:0.3 animations:^{
        [dst.view setAlpha:1.0];
    } completion:^(BOOL finished) {
        [src.view removeFromSuperview];
    }];
}

- (void)prepareDestinationController
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    [dst.view setAlpha:0.0];
    dst.view.center = src.view.center;
    dst.view.transform = src.view.transform;
    dst.view.bounds = src.view.bounds;
}

@end
