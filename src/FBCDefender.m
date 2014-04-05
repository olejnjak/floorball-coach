//
//  FBCDefender.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 05/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCDefender.h"

#define kFBCSideHalfSize 15

@implementation FBCDefender

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass overried

+ (UIColor*)color
{
    return [UIColor redColor];
}

- (UIBezierPath*)path
{
    if (nil == _path)
    {
        CGPoint start = CGPointMake(-kFBCSideHalfSize, kFBCSideHalfSize);
        
        _path = [[UIBezierPath alloc] init];
        
        [_path moveToPoint:start];
        [_path addLineToPoint:CGPointMake(kFBCSideHalfSize, kFBCSideHalfSize)];
        [_path addLineToPoint:CGPointMake(0, -kFBCSideHalfSize)];
        [_path addLineToPoint:start];
        
        [_path setLineWidth:3.0];
    }
    
    return _path;
}

@end
