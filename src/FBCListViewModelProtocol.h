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

- (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath*)indexPath;
- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath;

- (id<FBCTrainingUnitProtocol>)unitAtIndexPath:(NSIndexPath*)indexPath;
- (void)deleteRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)sortAZ;
- (void)sortZA;
- (void)sortOldFirst;
- (void)sortNewFirst;

@end
