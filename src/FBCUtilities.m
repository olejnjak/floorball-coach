//
//  FBCUtilities.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExercise.h"

static NSURL *g_libURL = nil;
static NSString *kFBCLibraryFile = @".unitLibrary";
static NSString *kFBCExerciseFolderName = @".exercises";
static NSString *kFBCExerciseNotesFile = @".notes";
static NSString *kFBCExerciseDrawablesFile = @".drawables";
static NSString *kFBCExerciseIconFile = @"icon.png";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Forward declarations

NSURL* FBCLibraryURL(void);
NSURL* FBCExerciseFolder(void);
NSURL* FBCFolderForExercise(FBCExercise*);
void FBCCreateDirectoryIfNotCreated(NSURL* url);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public functions

NSString* LOC(NSString* key)
{
    return NSLocalizedStringFromTable(key, @"localization", key);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Persistance helpers

NSURL* FBCLibraryFile(void)
{
    return [FBCLibraryURL() URLByAppendingPathComponent:kFBCLibraryFile];
}

NSURL* FBCFileForExerciseNotes(FBCExercise *exercise)
{
    NSURL *exerciseDir = FBCFolderForExercise(exercise);
    
    return [exerciseDir URLByAppendingPathComponent:kFBCExerciseNotesFile];
}

NSURL* FBCFileForExerciseDrawables(FBCExercise *exercise)
{
    NSURL *exerciseDir = FBCFolderForExercise(exercise);
    
    return [exerciseDir URLByAppendingPathComponent:kFBCExerciseDrawablesFile];
}

NSURL *FBCFileForExerciseIcon(FBCExercise* exercise)
{
    NSURL *exerciseDir = FBCFolderForExercise(exercise);
    
    return [exerciseDir URLByAppendingPathComponent:kFBCExerciseDrawablesFile];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Transformations

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

NSURL* FBCExerciseFolder(void)
{
    NSURL *lib = FBCLibraryURL();
    NSURL *result = [lib URLByAppendingPathComponent:kFBCExerciseFolderName];

    return result;
}

NSURL* FBCFolderForExercise(FBCExercise* exercise)
{
    NSUUID *uid = [exercise uid];
    NSString *uidString = [uid UUIDString];
    
    NSURL *exerciseFolder = FBCExerciseFolder();
    NSURL *result = [exerciseFolder URLByAppendingPathComponent:uidString];
    
    FBCCreateDirectoryIfNotCreated(result);
    
    return result;
}

void FBCCreateDirectoryIfNotCreated(NSURL* url)
{
    if (nil == url)
    {
        return;
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exists = [fm fileExistsAtPath:url.path isDirectory:&isDirectory];
    
    if (YES == exists && YES == isDirectory)
    {
        return;
    }
    
    [fm removeItemAtURL:url error:nil];
    [fm createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
}