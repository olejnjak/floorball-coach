//
//  FBCFieldController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCDrawingView;
@class FBCExercise;

@interface FBCFieldController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *fieldImageView;
@property (weak, nonatomic) IBOutlet FBCDrawingView *drawingView;

@property (nonatomic,strong) FBCExercise *exercise;

@end
