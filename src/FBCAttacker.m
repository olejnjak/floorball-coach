//
//  FBCAttacker.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 05/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCAttacker.h"

#define kFBCSemiDiameter 15

@implementation FBCAttacker

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

+ (UIColor*)color
{
    return [UIColor blueColor];
}

- (UIBezierPath*)path
{
    if (nil == _path)
    {
        _path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-kFBCSemiDiameter, -kFBCSemiDiameter,
                                                                  2*kFBCSemiDiameter, 2*kFBCSemiDiameter)];
        
        [_path setLineWidth:4.0];
    }
    
    return _path;
}

@end
