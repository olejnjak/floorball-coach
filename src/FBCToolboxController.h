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
