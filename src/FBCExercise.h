//
//  FBCExercise.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"

@interface FBCExercise : NSObject<FBCTrainingUnitProtocol>

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong,readonly) NSDate *dateCreated;

- (id)initWithName:(NSString*)name;

@end
