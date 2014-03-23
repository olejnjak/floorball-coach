//
//  UICollectionView+ReloadAnimated.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UICollectionView+ReloadAnimated.h"

// This animation is inspired by code which can be found here - https://discussions.apple.com/message/10534387#10534387
// Quoted at 23 March 2014.

@implementation UICollectionView (ReloadAnimated)

- (void)reloadDataAnimated:(BOOL)animated
{
    [self reloadData];
    
    if (animated)
    {
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self.delegate]; // optional
        [animation setType:kCATransitionFade];
        [animation setDuration:0.5];
        [animation setTimingFunction:[CAMediaTimingFunction
                                      functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setFillMode: @"extended"];
        
        [[self layer] addAnimation:animation forKey:@"reloadAnimation"];
    }
}

@end
