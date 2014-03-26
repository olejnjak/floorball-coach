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