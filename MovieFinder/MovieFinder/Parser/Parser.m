//
//  Parser.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "Parser.h"
#import "Constants.h"
#import "MoviesModel.h"
#import "MovieDetailsModel.h"

@implementation Parser


+(SearchResultModel*)parseSearchMoviesList:(id)responseData
{
    NSDictionary * responseDict = responseData;
    
    SearchResultModel * searchResult = [[SearchResultModel alloc] init];
    searchResult.moviesList = [[NSMutableArray alloc] init];
    searchResult.total = [[responseDict valueForKey:@"total"] intValue];
    
    NSArray * resMovies = INIT_STRING_IF_NIL([responseDict valueForKey:@"movies"]);
    
    for (int i = 0; i < resMovies.count; i++) {
        //
        MoviesModel * movMod = [[MoviesModel alloc] init];
        NSDictionary *singleMovie = resMovies[i];
        
        movMod.ids = INIT_STRING_IF_NIL([singleMovie valueForKey:@"id"]);
        movMod.year = [[singleMovie valueForKey:@"year"] intValue];
        movMod.title = INIT_STRING_IF_NIL([singleMovie valueForKey:@"title"]);
        movMod.thumbnail = INIT_STRING_IF_NIL([[singleMovie valueForKeyPath:@"posters"]valueForKey:@"thumbnail"] );
        [searchResult.moviesList addObject:movMod];
    }
    
    return searchResult;
}


+(MovieDetailsModel*)parseSearchMovieDetails:(id)responseData
{
    NSDictionary * singleMovie = responseData;
    
    MovieDetailsModel * moviesDetail = [[MovieDetailsModel alloc] init];
    
    moviesDetail.ids = INIT_STRING_IF_NIL([singleMovie valueForKey:@"id"]);
    moviesDetail.year = [[singleMovie valueForKey:@"year"] intValue];
    moviesDetail.title = INIT_STRING_IF_NIL([singleMovie valueForKey:@"title"]);
    moviesDetail.runtime = [[singleMovie valueForKey:@"runtime"] intValue];
    moviesDetail.studio = INIT_STRING_IF_NIL([singleMovie valueForKey:@"studio"]);
    moviesDetail.synopsis = INIT_STRING_IF_NIL([singleMovie valueForKey:@"synopsis"]);
    moviesDetail.release_dates = INIT_STRING_IF_NIL([[singleMovie valueForKeyPath:@"release_dates"]valueForKey:@"theater"] );
    moviesDetail.originalImage = INIT_STRING_IF_NIL([[singleMovie valueForKeyPath:@"posters"]valueForKey:@"original"] );
    moviesDetail.mpaa_rating = INIT_STRING_IF_NIL([singleMovie valueForKey:@"mpaa_rating"]);
    
    moviesDetail.genres = [singleMovie valueForKey:@"genres"];
    
    moviesDetail.abridged_directors = [singleMovie valueForKey:@"abridged_directors"];
    
    moviesDetail.abridged_cast = [singleMovie valueForKey:@"abridged_cast"];
    
    return moviesDetail;
}

@end
