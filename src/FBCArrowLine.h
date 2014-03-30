//
//  FBCArrowLine.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 30/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCDrawable.h"

@interface FBCArrowLine : NSObject<FBCDrawable>
{
    @protected UIBezierPath *_path;
}

+ (UIColor*)color;
+ (CGFloat)lineWidth;

@end
