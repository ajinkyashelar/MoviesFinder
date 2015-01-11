//
//  NetworkEngine.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

typedef void (^EngineResponseBlock)(AFHTTPRequestOperation *operation, id response);
typedef void (^EngineOperatoinBlockError)(AFHTTPRequestOperation *operation, NSError *error);

@interface NetworkEngine : NSObject

+ (instancetype)sharedAPIManager;

-(void)getMoviesListForSearchString:(NSString*)searchString onPage:(int)pageNumber  onCompletion:(EngineResponseBlock)completion onError:(EngineOperatoinBlockError)error;

-(void)getMoviesDetailsForId:(NSString*)movieID onCompletion:(EngineResponseBlock)completion onError:(EngineOperatoinBlockError)error;

@end
