//
//  FBCTrainingCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCListTableCell.h"

@class FBCTraining;

@interface FBCTrainingCell : FBCListTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNumberLabel;

@property (strong, nonatomic) FBCTraining *training;

- (IBAction)duplicateButtonTapped:(UIButton *)sender;

@end
