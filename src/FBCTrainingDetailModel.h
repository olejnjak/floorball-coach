//
//  FBCTrainingDetailModel.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../lib/LXReorderableCollectionViewFlowLayout/LXReorderableCollectionViewFlowLayout/LXReorderableCollectionViewFlowLayout.h"

static const NSInteger kFBCTrainingExercisesSection = 0;
static const NSInteger kFBCFavoriteExercisesSection = 1;
static const NSInteger kFBCRestOfExercisesSection = 2;

@class FBCTraining;

@interface FBCTrainingDetailModel : NSObject<UICollectionViewDelegate,UICollectionViewDataSource,
    LXReorderableCollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) FBCTraining *training;

- (id)initWithTraining:(FBCTraining*)training;

@end
