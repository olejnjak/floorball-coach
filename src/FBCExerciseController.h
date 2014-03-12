//
//  FBCExerciseController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCExerciseController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesTrailingConstraint;

- (IBAction)notesButtonPressed:(id)sender;

@end
