//
//  FBCFlipHorizontalSegue.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFlipHorizontalSegue.h"

@implementation FBCFlipHorizontalSegue

- (void)perform
{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    UIWindow *window = src.view.window;
    
    dst.view.center = src.view.center;
    dst.view.transform = src.view.transform;
    dst.view.bounds = src.view.bounds;
    
    [UIView transitionFromView:src.view toView:dst.view duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished)
     {
         [window setRootViewController:dst];
     }];
}


@end
