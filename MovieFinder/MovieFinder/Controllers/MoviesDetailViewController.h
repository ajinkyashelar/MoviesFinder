//
//  MoviesDetailViewController.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsModel.h"

@interface MoviesDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewDetails;
@property (nonatomic, strong) NSString * movieID;
@property (nonatomic, strong) MovieDetailsModel * movieDetailObj;
@property (nonatomic) CGFloat synopsisHeight;
@end
