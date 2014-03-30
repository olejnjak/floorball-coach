//
//  FBCUtilities.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

NSString* LOC(NSString *key);

NSURL *FBCLibraryFile(void);

CGPoint FBCRotatePointAroundPoint (CGPoint pointToRotate, CGFloat angle, CGPoint center);
CGFloat FBCDistanceBetweenPoints(CGPoint p1, CGPoint p2);
CGPoint FBCScalePointWithCenter(CGPoint pointToScale, CGFloat scale, CGPoint center);