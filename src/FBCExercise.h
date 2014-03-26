//
//  FBCExercise.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"

@class FBCTraining;
@class FBCNote;

@interface FBCExercise : NSObject<FBCTrainingUnitProtocol>

@property (nonatomic,weak) FBCTraining *parent;

@property (nonatomic,strong,readonly) NSDate *lastChange;
@property (nonatomic) BOOL favorite;

- (NSArray*)notes;
- (void)addNote:(FBCNote*)note;
- (void)removeNote:(FBCNote*)note;

@end
