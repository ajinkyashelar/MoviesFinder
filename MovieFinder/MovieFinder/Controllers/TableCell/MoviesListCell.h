//
//  MoviesListCell.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *nameMovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearMovieLabel;

@end
