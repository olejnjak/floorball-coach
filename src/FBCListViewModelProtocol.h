//
//  FBCListViewModelProtocol.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"

@protocol FBCListViewModelProtocol <NSObject>

+ (id<FBCListViewModelProtocol>)model;

- (NSInteger)count;

- (id<FBCTrainingUnitProtocol>)unitForIndexPath:(NSIndexPath*)indexPath;
- (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath*)indexPath;
- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath;
- (void)deleteRowAtIndexPath:(NSIndexPath*)indexPath;

@end
