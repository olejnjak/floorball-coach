//
//  FBCIAPModel.m
//  Floorball Coach
//
//  Created by Jakub Olejník on 31.10.14.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCIAPModel.h"

#define kRemoveAdsId @"cz.olejnjak.floorballcoach.removeads"

static FBCIAPModel *fbcIapModel = nil;

@implementation FBCIAPModel
{
    SKProduct *_removeAdsProduct;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (FBCIAPModel*)model
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fbcIapModel = [[FBCIAPModel alloc] init];
    });
    
    return fbcIapModel;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}

- (void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - SKPaymentTransactionObserver methods

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            case SKPaymentTransactionStateRestored:
            {
                NSString *identifier = [transaction.payment productIdentifier];
                
                [self boughtProductWithIdentifier:identifier];
                break;
            }
            case SKPaymentTransactionStateFailed:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(@"FBCIAPFailedTitle")
                                                                message:LOC(@"FBCIAPFailed") delegate:nil
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
                break;
            default:
                break;
        }
     
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = [response products];
    
    if ([products count] == 0)
    {
        return;
    }
    
    SKProduct *product = [response.products objectAtIndex:0];
    
    if ([product.productIdentifier isEqualToString:kRemoveAdsId])
    {
        _removeAdsProduct = product;
        
        [self.delegate iapAvailableChanged:self.iapAvailable];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (void)buyRemoveAds
{
    SKPayment *payment = [SKPayment paymentWithProduct:_removeAdsProduct];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (BOOL)shouldDisplayAds
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return NO == [ud boolForKey:kRemoveAdsId];
}

- (BOOL)iapAvailable
{
    return _removeAdsProduct != nil && [SKPaymentQueue canMakePayments];
}

- (void)requestProductsFromApple
{
    NSSet *identifiers = [NSSet setWithObject:kRemoveAdsId];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:identifiers];
    
    [request setDelegate:self];
    [request start];
}

- (void)restorePurchases
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)boughtProductWithIdentifier:(NSString*)identifier
{
    if ([identifier isEqualToString:kRemoveAdsId])
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        [ud setBool:YES forKey:kRemoveAdsId];
        [self.delegate adStateChanged:YES];
    }
}

@end
