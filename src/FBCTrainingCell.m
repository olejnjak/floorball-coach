//
//  FBCTrainingCell.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingCell.h"
#import "FBCTraining.h"
#import "FBCTrainingUnitLibrary.h"
#import "FBCListViewController.h"

@implementation FBCTrainingCell

@synthesize training = _training;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)duplicateButtonTapped:(UIButton *)sender
{
    FBCTraining *duplicate = [self.training copy];
    NSString *name = [duplicate name];
    NSString *duplicateName = [name stringByAppendingString:LOC(@"FBCCopy")];
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [duplicate setName:duplicateName];
    [library addTraining:duplicate];
    
    [self.parent refresh];
}

@end
