//
//  FBCShot.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 03/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCShot.h"

#define kFBCDoubleLineHalfDistance 5.0
#define kFBCLineWidth 4.0

static NSString *kFBCPath2Key = @"path2";
static NSString *kFBCMovedKey = @"moved";

@implementation FBCShot
{
    UIBezierPath *_path2;
    
    BOOL _wasMoved;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor magentaColor];
}

+ (CGFloat)lineWidth
{
    return kFBCLineWidth;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCopying methods

- (id)copyWithZone:(NSZone *)zone
{
    FBCShot *copy = [super copyWithZone:zone];
    
    copy->_path2 = [_path2 copyWithZone:zone];
    copy->_wasMoved = _wasMoved;
    
    return copy;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (nil != self)
    {
        _path2 = [aDecoder decodeObjectForKey:kFBCPath2Key];
        _wasMoved = [aDecoder decodeBoolForKey:kFBCMovedKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_path2 forKey:kFBCPath2Key];
    [aCoder encodeBool:_wasMoved forKey:kFBCMovedKey];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

- (id)initWithStartPoint:(CGPoint)startPoint
{
    self = [super initWithStartPoint:startPoint];
    
    if (nil != self)
    {
        _wasMoved = NO;
        _path2 = [[UIBezierPath alloc] init];
        [_path2 setLineWidth:kFBCLineWidth];
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point
{
    _beforeLastPoint = _lastPoint;
    _lastPoint = point;
    
    [self addTransformedPoint:point];
}

- (void)draw
{
    [[self.class color] setStroke];
    
    [_path stroke];
    [_path2 stroke];
    [self drawArrow];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (CGPoint)normalVector
{
    CGPoint vector = _lastPoint;
    
    vector.x -= _beforeLastPoint.x;
    vector.y -= _beforeLastPoint.y;
    
    CGFloat x = vector.x;
    
    vector.x = vector.y;
    vector.y = -x;
    
    return vector;
}

- (void)addTransformedPoint:(CGPoint)point
{
    CGPoint normalVector = [self normalVector];
    CGFloat vectorSize = FBCDistanceBetweenPoints(normalVector, CGPointZero);
    CGFloat scale = kFBCDoubleLineHalfDistance / vectorSize;
    CGPoint resultVector = FBCScalePointWithCenter(normalVector, scale, CGPointZero);
    
    CGAffineTransform transform1 = CGAffineTransformMakeTranslation(resultVector.x, resultVector.y);
    CGAffineTransform transform2 = CGAffineTransformMakeTranslation(-resultVector.x, -resultVector.y);
    
    CGPoint resultPoint1 = CGPointApplyAffineTransform(point, transform1);
    CGPoint resultPoint2 = CGPointApplyAffineTransform(point, transform2);
    
    if (NO == _wasMoved)
    {
        [_path moveToPoint:resultPoint1];
        [_path2 moveToPoint:resultPoint2];
        
        _wasMoved = YES;
    }
    
    [_path addLineToPoint:resultPoint1];
    [_path2 addLineToPoint:resultPoint2];
}

@end
