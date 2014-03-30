//
//  FBCArrowLine.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCArrowLine.h"

static const CGFloat kFBCArrowDistance = 30.0;

@implementation FBCArrowLine
{    
    CGPoint _lastPoint;
    CGPoint _beforeLastPoint;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor clearColor];
}

+ (CGFloat)lineWidth
{
    return 1.0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCDrawable methods

- (id)initWithStartPoint:(CGPoint)startPoint
{
    self = [super init];
    
    if (nil != self)
    {
        _path = [[UIBezierPath alloc] init];
        
        CGFloat lineWidth = [self.class lineWidth];
        
        [_path setLineWidth:lineWidth];
        [_path moveToPoint:startPoint];
        
        _beforeLastPoint = startPoint;
        _lastPoint = startPoint;
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point
{
    [_path addLineToPoint:point];
    
    _beforeLastPoint = _lastPoint;
    _lastPoint = point;
}

- (void)draw
{
    [[self.class color] set];
    
    [_path stroke];
    [self drawArrow];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)drawArrow
{
    CGPoint vector = _lastPoint;
    vector.x -= _beforeLastPoint.x;
    vector.y -= _beforeLastPoint.y;
    
    CGFloat length = FBCDistanceBetweenPoints(vector, CGPointZero);
    CGFloat scale = kFBCArrowDistance / length;
    
    CGPoint rotatedPoint1 = FBCRotatePointAroundPoint(_beforeLastPoint, M_PI/6, _lastPoint);
    CGPoint rotatedPoint2 = FBCRotatePointAroundPoint(_beforeLastPoint, -M_PI/6, _lastPoint);
    rotatedPoint1 = FBCScalePointWithCenter(rotatedPoint1, scale, _lastPoint);
    rotatedPoint2 = FBCScalePointWithCenter(rotatedPoint2, scale, _lastPoint);
    
    UIBezierPath *arrowPath = [[UIBezierPath alloc] init];
    CGFloat lineWidth = [self.class lineWidth];
    
    [arrowPath setLineWidth:lineWidth];
    [arrowPath moveToPoint:rotatedPoint1];
    [arrowPath addLineToPoint:_lastPoint];
    [arrowPath addLineToPoint:rotatedPoint2];
    
    [arrowPath stroke];
}

@end


