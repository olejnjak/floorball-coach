//
//  FBCExerciseDummy.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 04/05/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseDummy.h"

static NSString *kTestName = @"Test exercise";

@implementation FBCExerciseDummy

- (id)init
{
    self = [super initWithName:kTestName];
    
    return self;
}

- (NSArray*)drawables
{
    return nil;
}

- (NSArray*)notes
{
    return nil;
}

- (UIImage*)icon
{
    return nil;
}

- (void)addNote:(FBCNote*)note
{
    
}

- (void)removeNote:(FBCNote*)note
{
    
}

- (void)addDrawable:(id<FBCDrawable>)drawable
{
    
}

- (void)saveIcon:(UIImage*)icon
{
    
}

- (void)save
{
    
}

- (void)load
{
    
}

- (void)empty
{
    
}

@end
