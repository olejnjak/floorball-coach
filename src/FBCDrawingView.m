//
//  FBCDrawingView.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 29/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCDrawingView.h"

@implementation FBCDrawingView
{
    UIBezierPath *_path;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (nil != self)
    {
        [self setBackgroundColor:UIColor.clearColor];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView methods

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIColor redColor] set];
    [_path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    _path = [[UIBezierPath alloc] init];
    
    [_path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [_path addLineToPoint:point];
    [self setNeedsDisplay];
}

@end