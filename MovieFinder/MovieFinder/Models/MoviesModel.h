//
//  MoviesModel.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesModel : NSObject

@property (strong, nonatomic) NSString * ids;
@property (strong, nonatomic) NSString * title;
@property (nonatomic) int year;
@property (strong, nonatomic) NSString * thumbnail;


@end
