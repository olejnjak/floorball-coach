//
//  FBCListViewController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"

typedef enum
{
    FBCListViewControllerTypeUndefined,
    FBCListViewControllerTypeExercise,
    FBCListViewControllerTypeTraining
} FBCListViewControllerType;

@interface FBCListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBCControllerDoneProtocol>

@property (assign, nonatomic) FBCListViewControllerType type;

@end
