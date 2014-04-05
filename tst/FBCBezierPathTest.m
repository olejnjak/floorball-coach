//
//  FBCBezierPathTest.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 06/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

@interface FBCBezierPathTest : XCTestCase

@end

@implementation FBCBezierPathTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testContains
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(10, 10)];
    
    XCTAssertTrue([path containsPoint:CGPointMake(1, 1)]);
}

@end
