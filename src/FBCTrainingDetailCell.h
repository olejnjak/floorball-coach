//
//  FBCTrainingDetailCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCExercise;

@interface FBCTrainingDetailCell : UICollectionViewCell

@property (strong, nonatomic) FBCExercise *exercise;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
