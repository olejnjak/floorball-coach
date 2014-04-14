//
//  FBCExercise.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"
#import "FBCDrawable.h"

@class FBCTraining;
@class FBCNote;

@interface FBCExercise : NSObject<FBCTrainingUnitProtocol,NSCopying>

@property (nonatomic,weak) FBCTraining *parent;

@property (nonatomic,strong,readonly) NSDate *lastChange;
@property (nonatomic) BOOL favorite;
@property (nonatomic) NSUUID *uid;

- (NSArray*)drawables;
- (NSArray*)notes;
- (UIImage*)icon;

- (void)addNote:(FBCNote*)note;
- (void)removeNote:(FBCNote*)note;

- (void)addDrawable:(id<FBCDrawable>)drawable;

- (void)saveIcon:(UIImage*)icon;

- (void)save;
- (void)load;
- (void)empty;

@end
