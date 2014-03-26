//
//  FBCNote.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCNote.h"

static const NSString* kFBCNameKey = @"name";
static const NSString* kFBCDateCreatedKey = @"dateCreated";
static const NSString* kFBCTextKey = @"text";

@implementation FBCNote

@synthesize name = _name;
@synthesize dateCreated = _dateCreated;
@synthesize text = _text;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (nil != self)
    {
        NSString *dateCreatedString = [dictionary objectForKey:kFBCDateCreatedKey];
        
        self.dateCreated = [NSDate dateFromString:dateCreatedString];
        self.text = [dictionary objectForKey:kFBCTextKey];
        self.name = [dictionary objectForKey:kFBCNameKey];
    }
    
    return self;
}

- (NSDictionary*)structure
{
    NSMutableDictionary *structureDictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    NSString *dateCreatedString = [self.dateCreated dateToString];
    
    [structureDictionary setObject:self.name forKey:kFBCNameKey];
    [structureDictionary setObject:dateCreatedString forKey:kFBCDateCreatedKey];
    [structureDictionary setObject:self.text forKey:kFBCTextKey];
    
    return structureDictionary;
}

@end
