//
//  FBCIAPModel.h
//  Floorball Coach
//
//  Created by Jakub Olejník on 31.10.14.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol FBCIAPModelDelegate <NSObject>

- (void)adStateChanged:(BOOL)bought;
- (void)iapAvailableChanged:(BOOL)available;

@end

@interface FBCIAPModel : NSObject<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic,weak) id<FBCIAPModelDelegate> delegate;

+ (FBCIAPModel*)model;

- (void)buyRemoveAds;
- (BOOL)shouldDisplayAds;
- (BOOL)iapAvailable;

- (void)restorePurchases;
- (void)requestProductsFromApple;

@end
