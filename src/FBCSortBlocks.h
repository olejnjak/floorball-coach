//
//  FBCSortBlocks.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#define kFBCAtoZBlock ^NSComparisonResult(id obj1, id obj2) { \
    FBCTraining *t1 = obj1; \
    FBCTraining *t2 = obj2; \
    \
    NSString *t1name = [t1.name lowercaseString]; \
    NSString *t2name = [t2.name lowercaseString]; \
    \
    return [t1name compare:t2name]; \
}

#define kFBCZtoABlock ^NSComparisonResult(id obj1, id obj2) { \
    FBCTraining *t1 = obj1; \
    FBCTraining *t2 = obj2; \
    \
    NSString *t1name = [t1.name lowercaseString]; \
    NSString *t2name = [t2.name lowercaseString]; \
    \
    return [t2name compare:t1name]; \
}

#define kFBCOldFirstBlock ^NSComparisonResult(id obj1, id obj2) { \
    FBCTraining *t1 = obj1; \
    FBCTraining *t2 = obj2; \
    \
    return [t2.date compare:t1.date]; \
}

#define kFBCNewFirstBlock ^NSComparisonResult(id obj1, id obj2) { \
    FBCTraining *t1 = obj1; \
    FBCTraining *t2 = obj2; \
    \
    return [t1.date compare:t2.date]; \
}
