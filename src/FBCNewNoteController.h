//
//  FBCNoteDetailControllerViewController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCExercise;

@interface FBCNewNoteController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) FBCExercise *exercise;
@property (weak, nonatomic) UIPopoverController *popController;

- (IBAction)saveButtonTapped:(UIButton *)sender;

@end
