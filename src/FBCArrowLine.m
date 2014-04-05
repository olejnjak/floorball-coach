//
//  FBCArrowLine.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCArrowLine.h"

static const CGFloat kFBCArrowDistance = 30.0;
static const CGFloat kFBCArrowShift = 15.0;

@implementation FBCArrowLine

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
    self = [super initWithStartPoint:startPoint];
    
    if (nil != self)
    {
        _beforeLastPoint = startPoint;
        _lastPoint = startPoint;
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point
{
    [super addPoint:point];
    
    _beforeLastPoint = _lastPoint;
    _lastPoint = point;
}

- (void)draw
{
    [super draw];
    
    [self drawArrow];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (void)drawArrow
{
    // prepare directiion vector
    CGPoint vector = _lastPoint;
    vector.x -= _beforeLastPoint.x;
    vector.y -= _beforeLastPoint.y;
    
    // prepare points for arrow
    CGFloat length = FBCDistanceBetweenPoints(vector, CGPointZero);
    CGFloat scale = kFBCArrowDistance / length;
    CGPoint rotatedPoint1 = FBCRotatePointAroundPoint(_beforeLastPoint, M_PI/6, _lastPoint);
    CGPoint rotatedPoint2 = FBCRotatePointAroundPoint(_beforeLastPoint, -M_PI/6, _lastPoint);
    
    rotatedPoint1 = FBCScalePointWithCenter(rotatedPoint1, scale, _lastPoint);
    rotatedPoint2 = FBCScalePointWithCenter(rotatedPoint2, scale, _lastPoint);
    
    // draw arrow
    UIBezierPath *arrowPath = [[UIBezierPath alloc] init];
    CGFloat lineWidth = [self.class lineWidth];
    CGFloat shiftScale = kFBCArrowShift / length;
    CGPoint shiftVector = FBCScalePointWithCenter(vector, shiftScale, CGPointZero);
    
    [arrowPath setLineWidth:lineWidth];
    [arrowPath moveToPoint:rotatedPoint1];
    [arrowPath addLineToPoint:_lastPoint];
    [arrowPath addLineToPoint:rotatedPoint2];
    
    // translate arrow from the line's ending
    [arrowPath applyTransform:CGAffineTransformMakeTranslation(shiftVector.x, shiftVector.y)];
    
    [arrowPath stroke];
}

@end


