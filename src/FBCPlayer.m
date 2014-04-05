//
//  FBCPlayer.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 05/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCPlayer.h"

@implementation FBCPlayer
{
    CGPoint _centerPoint;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor blackColor];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCDrawable methods

- (id)initWithStartPoint:(CGPoint)startPoint
{
    self = [super init];
    
    if (nil != self)
    {
        _centerPoint = CGPointZero;
    }
    
    return self;
}

- (void)draw
{
    [[self.class color] setStroke];
    [self.path stroke];
}

- (void)addPoint:(CGPoint)point
{
    [self preparePathWithCenter:point];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (UIBezierPath*)path
{
    [[NSException exceptionWithName:@"AbstractMethodCalled"
                             reason:@"Method 'path' is meant to be abstract, so it shouldn't be called."
                           userInfo:nil] raise];
    
    return nil;
}

- (void)preparePathWithCenter:(CGPoint)center
{
    CGPoint vector = center;
    
    vector.x -= _centerPoint.x;
    vector.y -= _centerPoint.y;
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(vector.x, vector.y);
    
    [self.path applyTransform:moveTransform];
    
    _centerPoint = center;
}


@end
