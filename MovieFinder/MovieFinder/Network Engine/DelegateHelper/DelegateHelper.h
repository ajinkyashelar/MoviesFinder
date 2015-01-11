//
//  DelegateHelper.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DelegateHelper : NSObject

@property bool isNetworkMessageDisplayed;

+ (DelegateHelper*)getInstance;
- (BOOL)networkIsAvailableMessage;
- (BOOL)networkIsAvailable;
-(void)showAlertWithTitle:(NSString*)title withMessage:(NSString*)message;

@end
