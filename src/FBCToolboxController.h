//
//  FBCToolboxController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCDrawable.h"

@interface FBCToolboxController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *passButton;
@property (weak, nonatomic) IBOutlet UIButton *shotButton;
@property (weak, nonatomic) IBOutlet UIButton *coneButton;
@property (weak, nonatomic) IBOutlet UIButton *attackerButton;
@property (weak, nonatomic) IBOutlet UIButton *defenderButton;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
@property (weak, nonatomic) IBOutlet UIButton *lineButton;
@property (weak, nonatomic) IBOutlet UIButton *rubberButton;
@property (weak, nonatomic) IBOutlet UILabel *ballLabel;

+ (Class<FBCDrawable>)selectedTool;

- (IBAction)passSelected:(UIButton *)sender;
- (IBAction)shotSelected:(UIButton *)sender;
- (IBAction)runSelected:(UIButton *)sender;
- (IBAction)coneSelected:(UIButton *)sender;
- (IBAction)attackerSelected:(UIButton *)sender;
- (IBAction)defenderSelected:(UIButton *)sender;
- (IBAction)lineToolSelected:(UIButton *)sender;
- (IBAction)rubberToolSelected:(UIButton *)sender;

@end
