//
//  FBCUtilities.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

static NSURL *g_libURL = nil;
static NSString *kFBCLibraryFile = @".unitLibrary.json";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Forward declarations

NSURL* FBCLibraryURL(void);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public functions

NSString* LOC(NSString* key)
{
    return NSLocalizedStringFromTable(key, @"localization", key);
}

NSURL *FBCLibraryFile(void)
{
    return [FBCLibraryURL() URLByAppendingPathComponent:kFBCLibraryFile];
}

CGPoint FBCRotatePointAroundPoint (CGPoint pointToRotate, CGFloat angle, CGPoint center)
{
    CGAffineTransform baseTransform = CGAffineTransformMakeTranslation(-center.x, -center.y);
    CGAffineTransform startTransform = CGAffineTransformMakeTranslation(center.x, center.y);
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(angle);
    
    CGPoint result = CGPointApplyAffineTransform(pointToRotate, baseTransform);
    result = CGPointApplyAffineTransform(result, rotateTransform);
    result = CGPointApplyAffineTransform(result, startTransform);
    
    return result;
}

CGFloat FBCDistanceBetweenPoints(CGPoint p1, CGPoint p2)
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    
    return distance;
}

CGPoint FBCScalePointWithCenter(CGPoint pointToScale, CGFloat scale, CGPoint center)
{
    CGAffineTransform baseTransform = CGAffineTransformMakeTranslation(-center.x, -center.y);
    CGAffineTransform startTransform = CGAffineTransformMakeTranslation(center.x, center.y);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
    
    CGPoint result = CGPointApplyAffineTransform(pointToScale, baseTransform);
    result = CGPointApplyAffineTransform(result, scaleTransform);
    result = CGPointApplyAffineTransform(result, startTransform);
    
    return result;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private helpers

NSURL* FBCLibraryURL(void)
{
    if (g_libURL == nil)
    {
        NSError       *error = nil;
        NSFileManager *fm    = [NSFileManager defaultManager];
        
        g_libURL = [fm URLForDirectory:NSLibraryDirectory
                              inDomain:NSUserDomainMask | NSLocalDomainMask
                     appropriateForURL:nil create:NO error:&error];
    }
    
    return g_libURL;
}