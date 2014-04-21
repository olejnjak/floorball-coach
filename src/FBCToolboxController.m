//
//  FBCToolboxController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCToolboxController.h"

#import "FBCTools.h"

static Class<FBCDrawable> g_selectedTool = nil;

@implementation FBCToolboxController
{
    UIButton *_selectedButton;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

+ (Class<FBCDrawable>)selectedTool
{
    return g_selectedTool;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _selectedButton = nil;
    
    // select default tool
    [self runSelected:self.runButton];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)passSelected:(UIButton *)sender
{
    g_selectedTool = [FBCPass class];
    
    [self selectButton:sender];
}

- (IBAction)shotSelected:(UIButton *)sender
{
    g_selectedTool = [FBCShot class];
    
    [self selectButton:sender];
}

- (IBAction)runSelected:(UIButton *)sender
{
    g_selectedTool = [FBCRun class];
    
    [self selectButton:sender];
}

- (IBAction)coneSelected:(UIButton *)sender
{
    g_selectedTool = [FBCCone class];
    
    [self selectButton:sender];
}

- (IBAction)attackerSelected:(UIButton *)sender
{
    g_selectedTool = [FBCAttacker class];
    
    [self selectButton:sender];
}

- (IBAction)defenderSelected:(UIButton *)sender
{
    g_selectedTool = [FBCDefender class];
    
    [self selectButton:sender];
}

- (IBAction)lineToolSelected:(UIButton *)sender
{
    g_selectedTool = [FBCLine class];
    
    [self selectButton:sender];
}

- (IBAction)rubberToolSelected:(UIButton *)sender
{
    g_selectedTool = [FBCRubber class];
    
    [self selectButton:sender];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (UIColor*)deselectedBackgroundColor
{
    return [UIColor colorWithRed:0.02352941176471 green:0.07450980392157 blue:0.24313725490196 alpha:1.0];
}

+ (UIColor*)selectedBackgroundColor
{
    return [UIColor redColor];
}

- (void)selectButton:(UIButton*)button
{
    UIColor *selectedColor = [self.class selectedBackgroundColor];
    UIColor *backgroundColor = [self deselectedBackgroundColor];
    
    [_selectedButton setBackgroundColor:backgroundColor];
    [button setBackgroundColor:selectedColor];
    
    _selectedButton = button;
}

@end
