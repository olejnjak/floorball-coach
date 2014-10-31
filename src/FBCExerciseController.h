//
//  FBCExerciseController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#import "FBCControllerDoneProtocol.h"
#import "FBCExercise.h"

@interface FBCExerciseController : UIViewController<UIPopoverControllerDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerTopConstraint;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nameItem;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerView;

@property (weak, nonatomic) id<FBCControllerDoneProtocol> delegate;
@property (strong, nonatomic) FBCExercise *exercise;

+ (FBCExerciseController*) instantiateFromStoryboard:(NSString*)storyboardID;

- (IBAction)notesButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)fieldTapped:(UITapGestureRecognizer *)sender;
- (IBAction)closeAdTapped:(UIButton *)sender;

@end
