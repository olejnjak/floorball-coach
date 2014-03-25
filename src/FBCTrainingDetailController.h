//
//  FBCTrainingDetailController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"

@class FBCTraining;
@class LXReorderableCollectionViewFlowLayout;

@interface FBCTrainingDetailController : UIViewController<UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trainingName;
@property (weak, nonatomic) IBOutlet LXReorderableCollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) id<FBCControllerDoneProtocol> delegate;

@property (nonatomic, strong) FBCTraining *training;

- (IBAction)backButtonTapped:(UIBarButtonItem *)sender;

@end
