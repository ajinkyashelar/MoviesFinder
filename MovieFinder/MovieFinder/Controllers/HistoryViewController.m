//
//  HistoryViewController.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryListCell.h"
#import "HistoryTable.h"
#import "DataAccessor.h"
#import "AppDelegate.h"
#import "SearchMoviesViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize tableVIewHistory, historySearchStringsArray;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"History";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadTable];
}

-(NSMutableArray*)getHistorySearchStringsFromDB
{
    NSMutableArray * historyArray = [[DataAccessor getInstance] getAllHistorySearchStrings];
    
    return historyArray;
}

-(void)loadTable
{
    historySearchStringsArray = [self getHistorySearchStringsFromDB];
    
    [tableVIewHistory reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historySearchStringsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryListCell" forIndexPath:indexPath];
    
    HistoryTable * hisMod = historySearchStringsArray[historySearchStringsArray.count-indexPath.row-1];
    
    cell.searchStringLabel.text = hisMod.searchString;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    //segueHistorySearchString
    if ([[segue identifier] isEqualToString:@"segueSearchMoviesViewController"])
    {
        SearchMoviesViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [tableVIewHistory indexPathForSelectedRow];
        HistoryTable * hisMod = historySearchStringsArray[historySearchStringsArray.count-indexPath.row-1];
        vc.searchString = hisMod.searchString;
        vc.noReultsLabel.text = @"";
        [vc searchMoviesForString:hisMod.searchString];
    }
}


@end
