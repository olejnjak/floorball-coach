//
//  FBCListViewModelProtocol.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBCListViewModelProtocol <NSObject>

+ (id<FBCListViewModelProtocol>)model;
+ (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath*)indexPath;

- (NSInteger)count;

@end
