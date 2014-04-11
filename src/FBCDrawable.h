//
//  FBCDrawable.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBCDrawable <NSObject>

- (id)initWithStartPoint:(CGPoint)startPoint;

- (void)addPoint:(CGPoint)point;
- (void)draw;

@optional - (void)finish;

@end
