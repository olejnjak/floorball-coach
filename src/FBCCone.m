//
//  FBCCone.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 05/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCCone.h"

#define kFBCConeHalfSize 10.0

@implementation FBCCone

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

+ (UIColor*)color
{
    return [UIColor greenColor];
}

- (UIBezierPath*)path
{
    if (nil == _path)
    {
        _path = [[UIBezierPath alloc] init];
        
        [_path moveToPoint:CGPointMake(-kFBCConeHalfSize, -kFBCConeHalfSize)];
        [_path addLineToPoint:CGPointMake(kFBCConeHalfSize, kFBCConeHalfSize)];
        [_path moveToPoint:CGPointMake(-kFBCConeHalfSize, kFBCConeHalfSize)];
        [_path addLineToPoint:CGPointMake(kFBCConeHalfSize, -kFBCConeHalfSize)];
        
        [_path setLineWidth:3.0];
    }
    
    return _path;
}

@end
