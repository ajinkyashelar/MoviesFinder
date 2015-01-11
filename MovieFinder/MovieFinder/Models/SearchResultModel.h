//
//  SearchResultModel.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property (nonatomic) int total;
@property (strong, nonatomic) NSMutableArray * moviesList;

@end
