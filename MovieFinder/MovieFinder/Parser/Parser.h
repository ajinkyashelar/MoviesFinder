//
//  Parser.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "MovieDetailsModel.h"
#import "SearchResultModel.h"

@interface Parser : NSObject

+(SearchResultModel*)parseSearchMoviesList:(id)responseData;

+(MovieDetailsModel*)parseSearchMovieDetails:(id)responseData;

@end
