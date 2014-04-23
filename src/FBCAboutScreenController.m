//
//  FBCAboutScreenController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCAboutScreenController.h"

@implementation FBCAboutScreenController

@synthesize delegate = _delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

    [self.versionLabel setText:appVersionString];
    [self.creditsTextView setText:LOC(@"FBCFITCredits")];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)backButtonTapped:(UIButton *)sender
{
    if (self.delegate != nil)
    {
        [self.delegate controllerIsDone:self];
    }
}

@end
