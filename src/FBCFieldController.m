//
//  FBCFieldController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFieldController.h"

@implementation FBCFieldController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBackground];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)loadBackground
{
    UIImage *fieldBg = [UIImage imageWithPDFNamed:kFBCFieldImage atHeight:2048];
    
    [self.fieldImageView setImage:fieldBg];
}

@end
