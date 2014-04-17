//
//  FBCTrainingUnitLibraryTests.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 14/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FBCTrainingUnitLibrary.h"

@interface FBCTrainingUnitLibraryTests : XCTestCase

@property (nonatomic,strong) FBCTrainingUnitLibrary *library;

@end

@implementation FBCTrainingUnitLibraryTests

- (void)setUp
{
    self.library = [FBCTrainingUnitLibrary library];
}

@end
