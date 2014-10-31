//
//  FBCMainMenuViewController.h
//  Floorbal Coach
//
//  Created by Jakub Olejnik on 10/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"
#import "FBCIAPModel.h"

@interface FBCMainMenuController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,
                                                    FBCControllerDoneProtocol, FBCIAPModelDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mainMenu;

- (IBAction)removeAdsTapped:(UIButton *)sender;
- (IBAction)restoreTapped:(UIButton *)sender;

@end
