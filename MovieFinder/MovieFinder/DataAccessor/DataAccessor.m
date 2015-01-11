//
//  DataAccessor.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "DataAccessor.h"
#import "AppDelegate.h"

@implementation DataAccessor


//Singleton holder
DataAccessor *sharedInstanceDataAccessor = nil;


+(DataAccessor*)getInstance {
    if (nil == sharedInstanceDataAccessor) {
        sharedInstanceDataAccessor = [[DataAccessor alloc] init];
    }
    
    return sharedInstanceDataAccessor;
}

+ (instancetype)sharedAccessor
{
    static dispatch_once_t onceToken;
    
    static id _sharedManager;
    
    dispatch_once(&onceToken, ^
                  {
                      _sharedManager = [[DataAccessor alloc] init];
                  });
    
    return _sharedManager;
}


#pragma mark  History Items

-(void)saveHistoryItems:(NSString*)historyString
{
    AppDelegate* sharedAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [sharedAppDelegate managedObjectContext];

    NSMutableArray * allHistoryList = [self getAllHistorySearchStrings];
    
    BOOL isAlreadyInDB = NO;
    
    for (int i = 0; i<allHistoryList.count; i++)
    {
        HistoryTable * hisAllObj = allHistoryList[i];
        
        if ([hisAllObj.searchString isEqualToString:historyString]) {
            
            isAlreadyInDB = YES;
            
            break;
        }
    }
    
    if (!isAlreadyInDB)
    {
        HistoryTable * historyItem = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"HistoryTable"
                                      inManagedObjectContext:context];
        
        historyItem.searchString = historyString;
        
        NSLog(@"Saving history string : %@", historyItem.searchString)
        ;
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
}

-(NSMutableArray*)getAllHistorySearchStrings
{
    NSMutableArray * historyListList = [[NSMutableArray alloc] init];
    
    AppDelegate* sharedAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [sharedAppDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HistoryTable"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (HistoryTable *info in fetchedObjects) {
        
        [historyListList addObject:info];
    }
    
    return  historyListList;
}


@end
