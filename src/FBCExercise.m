//
//  FBCExercise.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExercise.h"
#import "FBCNote.h"

static const NSString *kFBCNameKey = @"name";
static const NSString *kFBCLastChangeKey = @"lastChange";
static const NSString *kFBCFavoriteKey = @"favorite";
static const NSString *kFBCNotesKey = @"notes";

@implementation FBCExercise
{
    NSMutableArray *_notes;
}

@synthesize parent = _parent;

@synthesize name = _name;
@synthesize lastChange = _lastChange;
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
    
    if (nil != self)
    {
        if ([name length] == 0)
        {
            return nil;
        }
        
        [self __setInitState];
        [self setName:name];
        _lastChange = [NSDate date];
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (nil != self)
    {
        NSString *lastChangeString = [dictionary objectForKey:kFBCLastChangeKey];
        NSNumber *favoriteNumber = [dictionary objectForKey:kFBCFavoriteKey];
        NSArray *notesArray = [dictionary objectForKey:kFBCNotesKey];
        
        self.name = [dictionary objectForKey:kFBCNameKey];
        self.favorite = [favoriteNumber boolValue];
        _lastChange = [NSDate dateFromString:lastChangeString];
        
        [notesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *noteDictionary = obj;
            FBCNote *note = [[FBCNote alloc] initWithDictionary:noteDictionary];
            
            [self.notesArray addObject:note];
        }];
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

- (NSDictionary*)structure
{
    NSMutableDictionary *structureDict = [NSMutableDictionary dictionaryWithCapacity:4];
    NSString *lastChangeString = [self.lastChange dateToString];
    NSNumber *favoriteNumber = [NSNumber numberWithBool:self.favorite];
    NSMutableArray *notesArray = [NSMutableArray arrayWithCapacity:self.notesArray.count];
    
    [structureDict setObject:self.name forKey:kFBCNameKey];
    [structureDict setObject:lastChangeString forKey:kFBCLastChangeKey];
    [structureDict setObject:favoriteNumber forKey:kFBCFavoriteKey];
    
    [self.notesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FBCNote *note = obj;
        NSDictionary *noteDictionary = [note structure];
        
        [notesArray addObject:noteDictionary];
    }];
    
    [structureDict setObject:notesArray forKey:kFBCNotesKey];
    
    return structureDict;
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
    if (NO == [object isKindOfClass:self.class])
    {
        return NO;
    }
    
    FBCExercise *other = object;
    BOOL nameEqual = [self.name isEqualToString:other.name];
    BOOL lastChangeEqual = [self.lastChange isEqualToDate:other.lastChange];
    
    return nameEqual && lastChangeEqual;
}

- (NSUInteger)hash
{
    NSUInteger nameHash = [self.name hash];
    NSUInteger changeHash = [self.lastChange hash];
    
    return nameHash + 2 * changeHash;
}

@end
