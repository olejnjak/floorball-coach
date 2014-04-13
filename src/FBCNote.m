//
//  FBCNote.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCNote.h"

static NSString* kFBCNameKey = @"name";
static NSString* kFBCDateCreatedKey = @"dateCreated";
static NSString* kFBCTextKey = @"text";

@implementation FBCNote

@synthesize name = _name;
@synthesize dateCreated = _dateCreated;
@synthesize text = _text;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        NSDate *dateCreated = [aDecoder decodeObjectForKey:kFBCDateCreatedKey];
        NSString *text = [aDecoder decodeObjectForKey:kFBCTextKey];
        NSString *name = [aDecoder decodeObjectForKey:kFBCNameKey];
        
        [self setDateCreated:dateCreated];
        [self setText:text];
        [self setName:name];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kFBCNameKey];
    [aCoder encodeObject:self.dateCreated forKey:kFBCDateCreatedKey];
    [aCoder encodeObject:self.text forKey:kFBCTextKey];
}

@end
