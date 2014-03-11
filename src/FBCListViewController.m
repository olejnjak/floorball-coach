//
//  FBCListViewController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCListViewController.h"

@interface FBCListViewController ()

@end

@implementation FBCListViewController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataDelegate methods

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender
{
    if (self.delegate != nil)
    {
        [self.delegate controllerIsDone:self];
    }
}

@end
