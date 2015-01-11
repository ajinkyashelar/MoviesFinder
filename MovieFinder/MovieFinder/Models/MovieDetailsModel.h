//
//  MovieDetailsModel.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailsModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * ids;
@property (nonatomic) int  year;
@property (nonatomic) int  runtime;
@property (nonatomic, strong) NSString * studio;
@property (nonatomic, strong) NSString * synopsis;
@property (nonatomic, strong) NSString * release_dates;
@property (nonatomic, strong) NSString * originalImage;
@property (nonatomic, strong) NSString * mpaa_rating;
@property (nonatomic, strong) NSArray * genres;
@property (nonatomic, strong) NSArray * abridged_directors;
@property (nonatomic, strong) NSArray * abridged_cast;

@end
