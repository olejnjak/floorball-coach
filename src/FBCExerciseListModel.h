//
//  FBCExerciseListModel.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCListViewModelProtocol.h"

@interface FBCExerciseListModel : NSObject<FBCListViewModelProtocol>
{
  @protected NSMutableArray *_exercises;
}

@end
