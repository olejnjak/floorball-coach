//
//  FBCScreenSwitchSegue.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFadeSegue.h"

@implementation FBCFadeSegue

- (void)perform
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    UIWindow *appWindow = src.view.window;
    
    [self prepareDestinationController];
    
    [UIView transitionFromView:src.view toView:dst.view duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished)
     {
         [appWindow performSelectorOnMainThread:@selector(setRootViewController:)
                                     withObject:dst
                                  waitUntilDone:NO];
         
         [src.view removeFromSuperview];
     }];
}

- (void)prepareDestinationController
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    dst.view.center = src.view.center;
    dst.view.transform = src.view.transform;
    dst.view.bounds = src.view.bounds;
}

@end
