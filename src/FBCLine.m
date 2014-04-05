//
//  FBCLine.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 06/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCLine.h"

@implementation FBCLine

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (UIColor*)color
{
    return [UIColor blackColor];
}

+ (CGFloat)lineWidth
{
    return 3.0;
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
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point
{
    [_path addLineToPoint:point];
}

- (void)draw
{
    [[self.class color] set];
    
    [_path stroke];
}

@end
