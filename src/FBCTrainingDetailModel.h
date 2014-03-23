//
//  FBCTrainingDetailModel.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBCTraining;

@interface FBCTrainingDetailModel : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) FBCTraining *training;

- (id)initWithTraining:(FBCTraining*)training;

@end
