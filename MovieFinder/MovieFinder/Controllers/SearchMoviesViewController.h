//
//  SearchMoviesViewController.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultModel.h"
#import "MNMBottomPullToRefreshManager.h"

@interface SearchMoviesViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, MNMBottomPullToRefreshManagerClient>
{
    @private
    
    MNMBottomPullToRefreshManager *pullToRefreshManager;
    SearchResultModel * moviesSearchList;
    int pageNum;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarMovies;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMovies;
@property (weak, nonatomic) IBOutlet UILabel *noReultsLabel;

@property (strong, nonatomic) NSString * searchString;
@property (nonatomic, strong) UITapGestureRecognizer *keyboardDismissGestureRecognizer;

-(void)searchMoviesForString:(NSString*)searchStringT;
@end
