//
//  FBCDrawingView.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 29/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCDrawingView.h"
#import "FBCDrawable.h"
#import "FBCToolboxController.h"
#import "FBCExercise.h"

@implementation FBCDrawingView
{
    id<FBCDrawable> _currentTool;
}

@synthesize exercise = _exercise;

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
    
    NSArray *exerciseDrawables = [self.exercise drawables];
    
    [exerciseDrawables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj draw];
    }];
    
    [_currentTool draw];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Touches handling

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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self finishTouch];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self finishTouch];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)saveCurrentTool
{
    NSMutableArray *exerciseDrawables = [self.exercise drawables];
    
    [exerciseDrawables addObject:_currentTool];
}

- (void)finishTouch
{
    [self saveCurrentTool];
    
    if ([_currentTool respondsToSelector:@selector(finish)])
    {
        [_currentTool finish];
        [self setNeedsDisplay];
    }
}

@end
