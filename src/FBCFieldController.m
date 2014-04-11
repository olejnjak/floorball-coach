//
//  FBCFieldController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFieldController.h"
#import "FBCDrawingView.h"

@implementation FBCFieldController

@synthesize exercise = _exercise;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.drawingView setExercise:self.exercise];
}

@end
