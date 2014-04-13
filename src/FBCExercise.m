//
//  FBCExercise.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExercise.h"
#import "FBCNote.h"

static NSString *kFBCNameKey = @"name";
static NSString *kFBCLastChangeKey = @"lastChange";
static NSString *kFBCFavoriteKey = @"favorite";

@implementation FBCExercise

@synthesize parent = _parent;

@synthesize name = _name;
@synthesize lastChange = _lastChange;
@synthesize favorite = _favorite;
@synthesize drawables = _drawables;
@synthesize notes = _notes;

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

- (void)__setInitState
{
    _notes = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        [self __setInitState];
        
        NSString *name = [aDecoder decodeObjectForKey:kFBCNameKey];
        BOOL favorite = [aDecoder decodeBoolForKey:kFBCFavoriteKey];
        NSDate *lastChange = [aDecoder decodeObjectForKey:kFBCLastChangeKey];
        
        [self setName:name];
        [self setFavorite:favorite];
        [self setLastChange:lastChange];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kFBCNameKey];
    [aCoder encodeObject:self.lastChange forKey:kFBCLastChangeKey];
    [aCoder encodeBool:self.favorite forKey:kFBCFavoriteKey];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCTrainingUnitProtocol methods

- (NSArray*)flatten
{
    return @[self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (NSMutableArray*)notes
{
    if (nil == _notes)
    {
        _notes = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _notes;
}

- (NSMutableArray*)drawables
{
    if (nil == _drawables)
    {
        _drawables = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _drawables;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (void)addNote:(FBCNote *)note
{
    if (nil == note)
    {
        return;
    }
    
    [self.notes addObject:note];
}

- (void)removeNote:(FBCNote *)note
{
    if (nil == note)
    {
        return;
    }
    
    [self.notes removeObject:note];
}

- (void)saveDrawables
{
    
}

- (void)loadDrawables
{
    
}

- (void)saveNotes
{
    
}

- (void)loadNotes
{
    
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
