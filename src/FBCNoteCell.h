//
//  FBCNoteCell.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCNote;

@interface FBCNoteCell : UITableViewCell

@property (weak, nonatomic) FBCNote *note;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
