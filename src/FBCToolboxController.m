//
//  FBCToolboxController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCToolboxController.h"

#import "FBCTools.h"

#define kFBCDefaultTool FBCRun

static Class<FBCDrawable> g_selectedTool = nil;

@implementation FBCToolboxController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

+ (Class<FBCDrawable>)selectedTool
{
    if (g_selectedTool == nil)
    {
        g_selectedTool = [kFBCDefaultTool class];
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
    g_selectedTool = [FBCAttacker class];
}

- (IBAction)defenderSelected:(UIButton *)sender
{
    g_selectedTool = [FBCDefender class];
}

- (IBAction)lineToolSelected:(UIButton *)sender
{
    g_selectedTool = [FBCLine class];
}

- (IBAction)rubberToolSelected:(UIButton *)sender
{
    g_selectedTool = [FBCRubber class];
}
@end
