//
//  UICollectionView+ReloadAnimated.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (ReloadAnimated)

- (void)reloadDataAnimated:(BOOL)animated;
- (void)reloadSection:(NSInteger)section animated:(BOOL)animated;

@end
