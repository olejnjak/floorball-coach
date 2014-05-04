//
//  FBCExerciseTests.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 14/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FBCExercise.h"

#import "FBCNoteDummy.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

static NSString *kExerciseTestName = @"Test exercise";
static u_int32_t kMaxRandomNumber = 100;

@interface FBCExerciseTests : XCTestCase

@property (nonatomic,strong) FBCExercise *exercise;

@end

@implementation FBCExerciseTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Test preparations

- (void)setUp
{
    [super setUp];

    self.exercise = [[FBCExercise alloc] initWithName:kExerciseTestName];
    
    DDLogVerbose(@"FBCEXERCISETESTS starting '%s'", __PRETTY_FUNCTION__);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Tests

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

- (void)testEmptyExercise
{
    NSArray *notes = [self.exercise notes];
    
    XCTAssertEqual(0, [notes count], @"Empty exercise should contain no notes.");
    
    NSArray *drawables = [self.exercise drawables];
    
    XCTAssertEqual(0, [drawables count], @"Empty exercise should contain no drawables.");
}

- (void)testAddNoteNil
{
    [self.exercise addNote:nil];
    
    NSArray *notes = [self.exercise notes];
    
    XCTAssertEqual(0, [notes count], @"Adding nil note succeeded.");
}

- (void)testAddNoteCorrect
{
    NSArray *notes = [self.exercise notes];
    FBCNote *noteDummy = [[FBCNoteDummy alloc] init];
    
    XCTAssertEqual(0, [notes count], @"New exercise is supposed to have no notes.");
    
    [self.exercise addNote:noteDummy];
    notes = [self.exercise notes];
    
    XCTAssertEqual(1, [notes count], @"Adding of note resulted in unexpected note count.");
}

- (void)testAddNoteCorrectRandom
{
    uint32_t randomNumber = arc4random() % kMaxRandomNumber;
    
    for (uint32_t i = 0; i < randomNumber; i++)
    {
        FBCNote *noteDummy = [[FBCNoteDummy alloc] init];
        [self.exercise addNote:noteDummy];
    }
    
    NSArray *notes = [self.exercise notes];
    
    XCTAssertEqual(randomNumber, [notes count], @"Adding of random number of notes resulted in unexpected note count.");
}

- (void)testRemoveNoteEmpty
{
    NSArray *notes = [self.exercise notes];
    FBCNote *noteDummy = [[FBCNoteDummy alloc] init];
    
    [self.exercise removeNote:noteDummy];
    
    XCTAssertEqualObjects(notes, [self.exercise notes]);
}

- (void)testRemoveNoteNotContained
{
    uint32_t randomNumber = arc4random() % kMaxRandomNumber;
    
    for (uint32_t i = 0; i < randomNumber; i++)
    {
        FBCNote *noteDummy = [[FBCNoteDummy alloc] init];
        [self.exercise addNote:noteDummy];
    }
    
    NSArray *notes = [self.exercise notes];
    FBCNote *noteDummy = [[FBCNoteDummy alloc] init];
    
    [self.exercise removeNote:noteDummy];
    
    XCTAssertEqualObjects(notes, [self.exercise notes], @"Removing note which wasn't contained changed notes array.");
}

@end
