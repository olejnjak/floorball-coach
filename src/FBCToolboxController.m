//
//  FBCToolboxController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCToolboxController.h"

#import "FBCRun.h"
#import "FBCShot.h"
#import "FBCPass.h"
#import "FBCCone.h"

static Class<FBCDrawable> g_selectedTool = nil;

@implementation FBCToolboxController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

+ (Class<FBCDrawable>)selectedTool
{
    if (g_selectedTool == nil)
    {
        g_selectedTool = [FBCRun class];
    }
    
    return g_selectedTool;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)passSelected:(UIButton *)sender
{
    g_selectedTool = [FBCPass class];
}

- (IBAction)shotSelected:(UIButton *)sender
{
    g_selectedTool = [FBCShot class];
}

- (IBAction)runSelected:(UIButton *)sender
{
    g_selectedTool = [FBCRun class];
}

- (IBAction)coneSelected:(UIButton *)sender
{
    g_selectedTool = [FBCCone class];
}

- (IBAction)attackerSelected:(UIButton *)sender
{
}

- (IBAction)defenderSelected:(UIButton *)sender
{
}
@end
