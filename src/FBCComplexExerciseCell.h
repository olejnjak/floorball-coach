//
//  FBCComplexExerciseCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCListTableCell.h"

@class FBCExercise;

@interface FBCComplexExerciseCell : FBCListTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@property (weak, nonatomic) FBCExercise *exercise;

- (IBAction)favoriteButtonTapped:(UIButton *)sender;
- (IBAction)duplicateButtonTapped:(UIButton *)sender;

@end
