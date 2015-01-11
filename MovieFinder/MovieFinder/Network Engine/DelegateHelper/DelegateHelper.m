//
//  DelegateHelper.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "DelegateHelper.h"
#import "Reachability.h"

@implementation DelegateHelper
@synthesize isNetworkMessageDisplayed;


//Singleton holder
DelegateHelper *sharedInstanceAppDelegateHelper = nil;


+(DelegateHelper*)getInstance {
    if (nil == sharedInstanceAppDelegateHelper) {
        sharedInstanceAppDelegateHelper = [[DelegateHelper alloc] init];
    }
    return sharedInstanceAppDelegateHelper;
}


#pragma mark
#pragma mark Check NetworkStatus
- (BOOL)networkIsAvailableMessage
{
	UIAlertView *errorView;
	
	if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        
		
        errorView = [[UIAlertView alloc]
					 initWithTitle:@"Alert"
					 message:@"Check internet connection"
					 delegate:self
					 cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[errorView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        
		return NO;
	} else {
        
        isNetworkMessageDisplayed = NO;
		return YES;
	}
}


- (BOOL)networkIsAvailable
{
	if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
		return NO;
	} else {
		return YES;
	}
}

-(void)showAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


@end
