//
//  FBCExerciseController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"

@interface FBCExerciseController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesTrailingConstraint;

@property (weak, nonatomic) id<FBCControllerDoneProtocol> delegate;

+ (FBCExerciseController*) instantiateFromStoryboard:(NSString*)storyboardID;

- (IBAction)notesButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender;

@end
