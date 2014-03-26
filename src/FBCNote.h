//
//  FBCNote.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBCNote : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *dateCreated;

- (id)initWithDictionary:(NSDictionary*)dictionary;

- (NSDictionary*)structure;

@end
