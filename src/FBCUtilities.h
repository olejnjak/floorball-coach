//
//  FBCUtilities.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

@class FBCExercise;

NSString* LOC(NSString *key);

NSURL *FBCLibraryFile(void);
NSURL *FBCFileForExerciseDrawables(FBCExercise* exercise);
NSURL *FBCFileForExerciseNotes(FBCExercise* exercise);

CGPoint FBCRotatePointAroundPoint (CGPoint pointToRotate, CGFloat angle, CGPoint center);
CGFloat FBCDistanceBetweenPoints(CGPoint p1, CGPoint p2);
CGPoint FBCScalePointWithCenter(CGPoint pointToScale, CGFloat scale, CGPoint center);