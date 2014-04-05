//
//  FBCLine.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 06/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCDrawable.h"

@interface FBCLine : NSObject<FBCDrawable>
{
    @protected UIBezierPath *_path;
}

+ (UIColor*)color;
+ (CGFloat)lineWidth;

@end
