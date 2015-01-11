//
//  HistoryTable.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryTable : NSManagedObject

@property (nonatomic, retain) NSString * searchString;

@end
