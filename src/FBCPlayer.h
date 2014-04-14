//
//  FBCPlayer.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 05/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCDrawable.h"

@interface FBCPlayer : NSObject<FBCDrawable>
{
    @protected UIBezierPath *_path;
}

@end
