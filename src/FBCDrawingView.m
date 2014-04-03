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
#import "FBCToolboxController.h"

@implementation FBCDrawingView
{
    id<FBCDrawable> _currentTool;
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
    
    [_currentTool draw];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    Class<FBCDrawable> selectedTool = [FBCToolboxController selectedTool];
    
    _currentTool = [[selectedTool.class alloc] initWithStartPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [_currentTool addPoint:point];
    [self setNeedsDisplay];
}

@end
