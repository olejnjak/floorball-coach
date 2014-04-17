//
//  FBCExerciseTests.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 14/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DDTTYLogger.h"
#import "DDASLLogger.h"

#import "FBCExercise.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

static NSString *kExerciseTestName = @"Test exercise";
static u_int32_t kMaxRandomNumber = 100;

@interface FBCExerciseTests : XCTestCase

@property (nonatomic,strong) FBCExercise *exercise;

@end

@implementation FBCExerciseTests

+ (void)setUp
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (void)setUp
{
    [super setUp];

    self.exercise = [[FBCExercise alloc] initWithName:kExerciseTestName];
    
    DDLogVerbose(@"FBCEXERCISETESTS starting '%s'", __PRETTY_FUNCTION__);
}

- (void)testAddDrawableCorrect
{
    id<FBCDrawable> drawable = mockProtocol(@protocol(FBCDrawable));
    NSArray *drawables = [self.exercise drawables];
    
    XCTAssertEqual(0, [drawables count], @"New exercise is expected to have no drawables.");
    
    [self.exercise addDrawable:drawable];
    drawables = [self.exercise drawables];
    
    XCTAssertEqual(1, [drawables count], @"Incorrect number of drawables after adding exactly one.");
    
    DDLogVerbose(@"FBCEXERCISETESTS '%s' test succeeded", __PRETTY_FUNCTION__);
}

- (void)testAddDrawableCorrectRandom
{
    u_int32_t randomNumber = arc4random() % kMaxRandomNumber;
    
    for (u_int32_t i = 0; i < randomNumber; i++)
    {
        id<FBCDrawable> drawable = mockProtocol(@protocol(FBCDrawable));
        
        [self.exercise addDrawable:drawable];
    }
    
    NSArray *drawables = [self.exercise drawables];
    NSUInteger count = [drawables count];
    
    XCTAssertEqual(randomNumber, count, @"Incorrect number of drawables (expected: %u, actual: %lu)", randomNumber,
                   (unsigned long)count);
    
    DDLogVerbose(@"FBCEXERCISETESTS '%s' test succeeded", __PRETTY_FUNCTION__);
}

- (void)testAddDrawableNil
{
    NSArray *drawables = [self.exercise drawables];
    
    XCTAssertEqual(0, [drawables count], @"New exercise is expected to have no drawables.");
    
    [self.exercise addDrawable:nil];
    drawables = [self.exercise drawables];
    
    XCTAssertEqual(0, [drawables count], @"Adding nil drawable shouldn't have changed anything.");
    
    DDLogVerbose(@"FBCEXERCISETESTS '%s' test succeeded", __PRETTY_FUNCTION__);
}

@end
