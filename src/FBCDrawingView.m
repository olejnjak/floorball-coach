//
//  FBCDrawingView.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 29/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCDrawingView.h"
#import "FBCDrawable.h"
#import "FBCShot.h"

@implementation FBCDrawingView
{
    id<FBCDrawable> _run;
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
    
    [_run draw];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    _run = [[FBCShot alloc] initWithStartPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [_run addPoint:point];
    [self setNeedsDisplay];
}

@end
