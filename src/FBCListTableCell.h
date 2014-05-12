//
//  FBCListTableCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/05/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCListViewController;

@interface FBCListTableCell : UITableViewCell

@property (nonatomic, weak) FBCListViewController *parent;

@end
