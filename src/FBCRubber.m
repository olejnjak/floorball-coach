//
//  FBCRubber.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCRubber.h"

static const CGFloat kFBCCircleHalfSize = 20.0;

@implementation FBCRubber
{
    CGPoint _lastPoint;
    BOOL _finished;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

+ (CGFloat)lineWidth
{
    return kFBCCircleHalfSize * 2;
}

+ (UIColor*)color
{
    return [UIColor whiteColor];
}

- (id)initWithStartPoint:(CGPoint)startPoint
{
    self = [super initWithStartPoint:startPoint];
    
    if (nil != self)
    {
        _lastPoint = startPoint;
        _finished = NO;
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point
{
    [super addPoint:point];
    
    _lastPoint = point;
}

- (void)draw
{
    [super draw];
    
    if (NO == _finished)
    {
        UIBezierPath *circlePath = [self circlePath];
        
        [UIColor.lightGrayColor setFill];
        [UIColor.grayColor setStroke];
        
        [circlePath stroke];
        [circlePath fill];
    }
}

- (void)finish
{
    _finished = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (UIBezierPath*)circlePath
{
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_lastPoint.x - kFBCCircleHalfSize,
                                                                             _lastPoint.y - kFBCCircleHalfSize,
                                                                             kFBCCircleHalfSize * 2,
                                                                             kFBCCircleHalfSize * 2)];
    
    return circle;
}

@end
