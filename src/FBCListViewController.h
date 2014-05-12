//
//  FBCListViewController.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBCControllerDoneProtocol.h"

typedef enum
{
    FBCListViewControllerTypeUndefined,
    FBCListViewControllerTypeExercise,
    FBCListViewControllerTypeTraining,
    FBCListViewControllerTypeFavorite
} FBCListViewControllerType;

@interface FBCListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBCControllerDoneProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *typeChangeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (assign, nonatomic) FBCListViewControllerType type;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addButtonPressed:(UIBarButtonItem *)sender;

- (void)refresh;

@end
