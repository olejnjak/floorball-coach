//
//  FBCPass.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCPass.h"

static const CGFloat kFBCLineWidth = 3.0;

@implementation FBCPass

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor orangeColor];
}

+ (CGFloat)lineWidth
{
    return kFBCLineWidth;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

- (void)draw
{
    CGFloat pattern[2] = {10,5};
    [_path setLineDash:pattern count:2 phase:0];
    
    [super draw];
}

@end
