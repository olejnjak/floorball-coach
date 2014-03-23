//
//  FBCEditExerciseNameController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 22/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCTrainingUnitProtocol.h"

@interface FBCEditUnitNameController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic, weak) id<FBCTrainingUnitProtocol> unit;
@property (nonatomic, weak) UIPopoverController *popController;

- (IBAction)saveButtonTapped:(UIButton *)sender;

@end
