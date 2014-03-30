//
//  FBCRun.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCRun.h"

static const CGFloat kFBCLineWidth = 4.0;

@implementation FBCRun

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor blueColor];
}

+ (CGFloat)lineWidth
{
    return kFBCLineWidth;
}

@end

