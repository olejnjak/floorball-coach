//
//  FBCTrainingCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCTrainingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNumberLabel;

@end
