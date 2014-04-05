//
//  FBCArrowLine.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCLine.h"

@interface FBCArrowLine : FBCLine
{
    @protected CGPoint _lastPoint;
    @protected CGPoint _beforeLastPoint;
}

- (void)drawArrow;

@end
