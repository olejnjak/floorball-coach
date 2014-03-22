//
//  FBCExerciseController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"
#import "FBCExercise.h"

@interface FBCExerciseController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesTrailingConstraint;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) id<FBCControllerDoneProtocol> delegate;
@property (strong, nonatomic) FBCExercise *exercise;

+ (FBCExerciseController*) instantiateFromStoryboard:(NSString*)storyboardID;

- (IBAction)notesButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)fieldTapped:(UITapGestureRecognizer *)sender;

@end
