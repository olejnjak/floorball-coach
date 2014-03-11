//
//  FBCAboutScreenController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"

@interface FBCAboutScreenController : UIViewController

- (IBAction)backButtonTapped:(UIButton *)sender;

@property (weak, nonatomic) id<FBCControllerDoneProtocol> delegate;

@end
