//
//  DataAccessor.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "HistoryTable.h"

@interface DataAccessor : NSObject

+ (instancetype)sharedAccessor;

+(DataAccessor*)getInstance;

-(void)saveHistoryItems:(NSString*)historyString;

-(NSMutableArray*)getAllHistorySearchStrings;

@end
