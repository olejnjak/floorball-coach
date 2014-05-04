//
//  FBCTrainingTests.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 04/05/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FBCTraining.h"

#import "FBCExerciseDummy.h"

static NSString *kTestTrainingName = @"Test training";
static uint32_t kMaxRandomNumber = 100;

@interface FBCTrainingTests : XCTestCase

@property (nonatomic, strong) FBCTraining *training;

@end

@implementation FBCTrainingTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Test preparations

- (void)setUp
{
    self.training = [[FBCTraining alloc] initWithName:kTestTrainingName];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Tests

- (void)testEmptyTraining
{
    NSArray *exercises = [self.training exercises];
    
    XCTAssertEqual(0, [exercises count], @"Empty training should contain no exercises.");
}

- (void)testAddExerciseNil
{
    NSArray *exercises = [self.training exercises];
    
    [self.training addExercise:nil];
    
    XCTAssertEqualObjects(exercises, [self.training exercises], @"Adding nil as exercise succeeded.");
}

- (void)testAddExerciseCorrect
{
    FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] init];
    
    [self.training addExercise:exerciseDummy];
    
    NSArray *exercises = [self.training exercises];
    
    XCTAssertEqual(1, [exercises count], @"Adding exercise resulted in unexpected exercise count.");
}

- (void)testAddExerciseCorrectRandom
{
    uint32_t randomNumber = [self addRandomExercises];
    NSArray *exercises = [self.training exercises];
    
    XCTAssertEqual(randomNumber, [exercises count], @"Adding exercise resulted in unexpected exercise count.");
}

- (void)testAddExerciseToIndexNil
{
    NSArray *exercises = [self.training exercises];
    
    [self.training addExercise:nil toIndex:0];
    
    XCTAssertEqualObjects(exercises, [self.training exercises], @"Adding nil as exercise succeeded.");
}

- (void)testAddExerciseToIndexCorrect
{
    uint32_t randomNumber = [self addRandomExercises];
    NSInteger index = arc4random() % randomNumber;
    FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] initWithName:@"abc"];
    
    [self.training addExercise:exerciseDummy toIndex:index];
    
    NSArray *exercises = [self.training exercises];
    FBCExercise *itemAtTargetIndex = [exercises objectAtIndex:index];
    
    XCTAssertEqual(randomNumber+1, [exercises count], @"Wrong number of exercises.");
    XCTAssertNotNil(itemAtTargetIndex, @"Target element should not be nil.");
    XCTAssertEqualObjects(exerciseDummy, itemAtTargetIndex, @"Element at target index is unexpected.");
}

- (void)testAddExercisesNil
{
    NSArray *exercises = [self.training exercises];
    
    [self.training addExercises:nil];
    
    XCTAssertEqualObjects(exercises, [self.training exercises]);
}

- (void)testAddExercisesCorrect
{
    FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] init];
    
    [self.training addExercises:@[exerciseDummy]];
    
    XCTAssertEqualObjects(@[exerciseDummy], [self.training exercises]);
}

- (void)testAddExercisesCorrectRandom
{
    NSUInteger randomNumber = arc4random() % kMaxRandomNumber;
    NSMutableArray *mutableExercises = [NSMutableArray arrayWithCapacity:randomNumber];
    
    for (NSUInteger i = 0; i < randomNumber; i++)
    {
        FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] init];
        
        [mutableExercises addObject:exerciseDummy];
    }
    
    [self.training addExercises:mutableExercises];
    
    XCTAssertEqualObjects(mutableExercises, [self.training exercises]);
}

- (void)testRemoveExerciseCorrect
{
    [self addRandomExercises];
    
    FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] initWithName:@"abc"];
    
    [self.training addExercise:exerciseDummy];
    
    NSArray *exercises = [self.training exercises];
    
    XCTAssertTrue([exercises containsObject:exerciseDummy], @"Added exercise hasn't been added to training.");
    
    [self.training removeExercise:exerciseDummy];
    exercises = [self.training exercises];
    
    XCTAssertFalse([exercises containsObject:exerciseDummy], @"Deleted exercise has been found in training.");
}

- (void)testRemoveExerciseNotContained
{
    [self addRandomExercises];
    
    FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] initWithName:@"abc"];
    
    NSArray *exercises = [self.training exercises];
    
    XCTAssertFalse([exercises containsObject:exerciseDummy], @"Training contains exercise which hasn't been added.");
    
    [self.training removeExercise:exerciseDummy];
    exercises = [self.training exercises];
    
    XCTAssertFalse([exercises containsObject:exerciseDummy],
                   @"Deleting exercise which isn't in the training changed exercise array.");
}

- (void)testRemoveExerciseNil
{
    [self addRandomExercises];
    
    NSArray *exercises = [self.training exercises];
    
    [self.training removeExercise:nil];
    
    XCTAssertEqualObjects(exercises, [self.training exercises]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (uint32_t)addRandomExercises
{
    uint32_t randomNumber = arc4random() % kMaxRandomNumber;
    
    for (uint32_t i = 0; i < randomNumber; i++)
    {
        FBCExercise *exerciseDummy = [[FBCExerciseDummy alloc] init];
        
        [self.training addExercise:exerciseDummy];
    }
    
    return randomNumber;
}

@end
