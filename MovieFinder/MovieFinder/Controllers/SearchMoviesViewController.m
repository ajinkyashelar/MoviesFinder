//
//  SearchMoviesViewController.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "SearchMoviesViewController.h"
#import "MoviesListCell.h"
#import "NetworkEngine.h"
#import "Parser.h"
#import "UIImageView+WebCache.h"
#import "MoviesModel.h"
#import "MoviesDetailViewController.h"
#import "HistoryTable.h"
#import "DataAccessor.h"
#import "AppDelegate.h"

@interface SearchMoviesViewController ()

@end

@implementation SearchMoviesViewController
@synthesize searchBarMovies, tableViewMovies;
@synthesize searchString;
@synthesize noReultsLabel;
@synthesize keyboardDismissGestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageNum = 1;
    
    self.title = @"Movies Finder";
    
    self.noReultsLabel.text = @"Search For Movies here!";
    tableViewMovies.hidden = YES;
    
    searchBarMovies.text = searchString;
    
    moviesSearchList = [[SearchResultModel alloc] init];
    
    pullToRefreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:tableViewMovies withClient:self];
}

-(void)loadTable
{
    if (moviesSearchList.total > pageNum*kNumberOfMovies)
    {
        pageNum++;
        [self getMoviesListForSearchString:searchString atPage:pageNum];
    }
    else
    {
        [pullToRefreshManager tableViewReloadFinished];
    }

}

-(void)displayNoResults:(BOOL)noResults
{
    if (noResults) {
        
        noReultsLabel.text = @"No Results!";
        [self.view bringSubviewToFront:noReultsLabel];
        tableViewMovies.hidden = YES;
    }
    else
    {
        tableViewMovies.hidden = NO;
        [self.view bringSubviewToFront:tableViewMovies];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager relocatePullToRefreshView];
}


#pragma mark - Search Movie API 

-(void)getMoviesListForSearchString:(NSString*)searchStringT atPage:(int)pageNumber
{
    searchStringT = [searchStringT stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       noReultsLabel.text = @"Searching for Movies...";
                   });
    
    
    [[NetworkEngine sharedAPIManager] getMoviesListForSearchString:searchStringT onPage:pageNumber onCompletion:^(AFHTTPRequestOperation *operation, id response) {
        //
        
        if (pageNumber == 1) // First set of result
        {
            moviesSearchList = [Parser parseSearchMoviesList:response];
        }
        else
        {
            SearchResultModel* searcfModel = [Parser parseSearchMoviesList:response];
            [moviesSearchList.moviesList addObjectsFromArray:searcfModel.moviesList];
        }
        
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           if (moviesSearchList.moviesList.count != 0) {
                               [self displayNoResults:NO];
                           }
                           else
                           {
                               [self displayNoResults:YES];
                           }
                           
                           [tableViewMovies reloadData];
                           [pullToRefreshManager tableViewReloadFinished];
                           
                           
                       });
        
        
    } onError:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           noReultsLabel.text = @"Some network Problem!";
                       });
    }];
    
}

#pragma mark - Search Bar Delegate Methods

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if(keyboardDismissGestureRecognizer == nil)
    {
        keyboardDismissGestureRecognizer = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
        keyboardDismissGestureRecognizer.cancelsTouchesInView = YES;
        
        [self.view addGestureRecognizer:keyboardDismissGestureRecognizer];
    }
}

- (void) dismissKeyboard
{
    [self performSelector:@selector(dismissKeyboardSelector) withObject:nil afterDelay:0.01];
}

- (void) dismissKeyboardSelector
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:keyboardDismissGestureRecognizer];
    keyboardDismissGestureRecognizer = nil;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchMoviesForString:searchBar.text];
    
    [searchBar resignFirstResponder];
}

-(void)searchMoviesForString:(NSString*)searchStringT
{
    pageNum = 1;
    
    searchString = searchStringT;
    
    [[DataAccessor getInstance] saveHistoryItems:searchString];
    
    [self getMoviesListForSearchString:searchString atPage:pageNum];
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moviesSearchList.moviesList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesListCell" forIndexPath:indexPath];
    
    MoviesModel * movMod = moviesSearchList.moviesList[indexPath.row];
    
    [cell.imageViewThumbnail sd_setImageWithURL:[NSURL URLWithString:movMod.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameMovieLabel.text = movMod.title;
    if (movMod.year != 0)
        cell.yearMovieLabel.text = [NSString stringWithFormat:@"%d", movMod.year];
    
    return cell;
}


#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pullToRefreshManager tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [pullToRefreshManager tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:0.0f];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"segueMovieDetails"])
    {
        MoviesDetailViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [tableViewMovies indexPathForSelectedRow];
        MoviesModel * movMod = moviesSearchList.moviesList[indexPath.row];
        vc.movieID = movMod.ids;
    }
}


@end
