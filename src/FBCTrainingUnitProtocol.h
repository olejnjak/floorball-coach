//
//  FBCTrainingUnit.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBCTrainingUnitProtocol <NSObject, NSCoding>

@property (nonatomic,strong) NSString *name;

- (id)initWithName:(NSString*)name;

- (NSArray*)flatten;

@end
