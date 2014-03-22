//
//  FBCEditExerciseNameController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 22/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCExercise;

@interface FBCEditExerciseNameController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic, weak) FBCExercise* exercise;
@property (nonatomic, weak) UIPopoverController *popController;

- (IBAction)saveButtonTapped:(UIButton *)sender;

@end
