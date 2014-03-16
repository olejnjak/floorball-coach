//
//  FBCSortViewController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCSortViewController.h"

#define kFBCAtoZTag 1
#define kFBCZtoATag 2
#define kFBCNewFirstTag 3
#define kFBCOldFirstTag 4

@implementation FBCSortViewController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger cellTag = [cell tag];
    
    switch (cellTag)
    {
        case kFBCAtoZTag:
            self.aToZBlock();
            break;
        case kFBCZtoATag:
            self.zToABlock();
            break;
        case kFBCNewFirstTag:
            self.newFirstBlock();
            break;
        case kFBCOldFirstTag:
            self.oldFirstBlock();
            break;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}

@end
