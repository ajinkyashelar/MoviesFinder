//
//  Constants.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#ifndef MovieFinder_Constants_h
#define MovieFinder_Constants_h

#define INIT_STRING_IF_NIL(x) (nil == x ? @"" : x)

#define kRottenTomatoAPIKey @"44ze5s3dt5y58y5v8pq3xft5"

#define kNumberOfMovies 10

#define kMovie_Search @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=%@&page_limit=%d&page=%d&apikey=%@"


#define kMovie_Details @"http://api.rottentomatoes.com/api/public/v1.0/movies/%@.json?apikey=%@"

#endif
