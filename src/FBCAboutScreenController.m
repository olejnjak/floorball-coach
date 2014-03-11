//
//  FBCAboutScreenController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCAboutScreenController.h"

@interface FBCAboutScreenController ()

@end

@implementation FBCAboutScreenController

@synthesize delegate = _delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions -

- (IBAction)backButtonTapped:(UIButton *)sender
{
    if (self.delegate != nil)
    {
        [self.delegate controllerIsDone:self];
    }
}

@end
