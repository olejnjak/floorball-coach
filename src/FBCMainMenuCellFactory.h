//
//  FBCMainMenuCellFactory.h
//  Floorbal Coach
//
//  Created by Jakub Olejnik on 10/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBCMainMenuCellFactory : NSObject

+ (NSString*)reusableIdForIndexPath:(NSIndexPath*)indexPath andOrientation:(UIInterfaceOrientation)orientation;

@end
