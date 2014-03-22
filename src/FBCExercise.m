//
//  FBCExercise.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExercise.h"

@implementation FBCExercise
{
    NSMutableArray *_notes;
}

@synthesize parent = _parent;

@synthesize name = _name;
@synthesize dateCreated = _dateCreated;
@synthesize favorite = _favorite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    return nil;
}

- (id)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self != nil)
    {
        if ([name length] == 0)
        {
            return nil;
        }
        
        [self __setInitState];
        [self setName:name];
        _dateCreated = [NSDate date];
    }
    
    return self;
}

- (void)__setInitState
{
    _notes = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCTrainingUnitProtocol methods

- (NSArray*)flatten
{
    return @[self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (NSMutableArray*)notesArray
{
    if (_notes == nil)
    {
        _notes = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _notes;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (NSArray*)notes
{
    NSArray *result = [NSArray arrayWithArray:self.notesArray];
    
    return result;
}

- (void)addNote:(FBCNote *)note
{
    if (nil == note)
    {
        return;
    }
    
    [self.notesArray addObject:note];
}

- (void)removeNote:(FBCNote *)note
{
    if (nil == note)
    {
        return;
    }
    
    [self.notesArray removeObject:note];
}

@end
