//
//  FBCSortViewController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 16/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBCControllerDoneProtocol.h"

typedef void (^FBCSortBlock)();

@interface FBCSortViewController : UITableViewController<UITableViewDelegate>

@property (nonatomic,strong) FBCSortBlock aToZBlock;
@property (nonatomic,strong) FBCSortBlock zToABlock;
@property (nonatomic,strong) FBCSortBlock newFirstBlock;
@property (nonatomic,strong) FBCSortBlock oldFirstBlock;

@property (nonatomic,weak) UIPopoverController *popover;

@end
