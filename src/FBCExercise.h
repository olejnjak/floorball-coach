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

@property (nonatomic,strong) NSDate *lastChange;
@property (nonatomic) BOOL favorite;
@property (nonatomic,strong) NSMutableArray *drawables;
@property (nonatomic,strong) NSMutableArray *notes;

- (void)addNote:(FBCNote*)note;
- (void)removeNote:(FBCNote*)note;

- (void)saveNotes;
- (void)loadNotes;

- (void)saveDrawables;
- (void)loadDrawables;

@end
