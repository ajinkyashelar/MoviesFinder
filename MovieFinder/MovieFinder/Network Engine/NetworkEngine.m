//
//  NetworkEngine.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "NetworkEngine.h"
#import "DelegateHelper.h"
#import "Constants.h"

@implementation NetworkEngine


+ (instancetype)sharedAPIManager
{
    static dispatch_once_t onceToken;
    
    static id _sharedManager;
    
    dispatch_once(&onceToken, ^
                  {
                      _sharedManager = [[NetworkEngine alloc] init];
                  });
    
    return _sharedManager;
}

-(void)getMoviesListForSearchString:(NSString*)searchString onPage:(int)pageNumber  onCompletion:(EngineResponseBlock)completion onError:(EngineOperatoinBlockError)error
{
    DelegateHelper * helper = [DelegateHelper getInstance];
    
    if ([helper networkIsAvailableMessage])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                
        NSString * url = [NSString stringWithFormat:kMovie_Search, searchString, kNumberOfMovies, pageNumber, kRottenTomatoAPIKey];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            completion(operation, responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {

            NSLog(@"Error: %@", error);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            error (operation, err);
        }];
    }
    
}

-(void)getMoviesDetailsForId:(NSString*)movieID onCompletion:(EngineResponseBlock)completion onError:(EngineOperatoinBlockError)error
{
    DelegateHelper * helper = [DelegateHelper getInstance];
    
    if ([helper networkIsAvailableMessage])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString * url = [NSString stringWithFormat:kMovie_Details, movieID, kRottenTomatoAPIKey];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            completion(operation, responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            
            NSLog(@"Error: %@", error);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            error (operation, err);
        }];
    }
    
}

@end
