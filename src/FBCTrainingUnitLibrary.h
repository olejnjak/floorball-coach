//
//  FBCTrainingUnitLibrary.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"

@interface FBCTrainingUnitLibrary : NSObject
{
    @protected NSMutableArray *_units;
}

+ (FBCTrainingUnitLibrary*)library;

- (void)addUnit:(id<FBCTrainingUnitProtocol>)unit;
- (void)removeUnit:(id<FBCTrainingUnitProtocol>)unit;

- (NSArray*)units;
- (NSArray*)flatUnits;

- (NSArray*)exercises;

- (NSUInteger)count;

- (void)loadStructure;
- (void)saveStructure;

@end
