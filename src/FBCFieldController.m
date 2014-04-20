//
//  FBCFieldController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFieldController.h"
#import "FBCDrawingView.h"
#import "FBCExercise.h"

@implementation FBCFieldController

@synthesize exercise = _exercise;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.drawingView setExercise:self.exercise];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self applyMask];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.exercise saveIcon:image];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)applyMask
{
    CGRect frame = [self.view bounds];    
    UIBezierPath *mask = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:10.0];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    [layer setBackgroundColor:UIColor.clearColor.CGColor];
    [layer setFillColor:UIColor.blackColor.CGColor];
    [layer setPath:mask.CGPath];
    
    [self.view.layer setMask:layer];
}


@end
