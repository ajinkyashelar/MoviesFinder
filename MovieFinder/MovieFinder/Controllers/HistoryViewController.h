//
//  HistoryViewController.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 10/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIewHistory;
@property (strong, nonatomic) NSMutableArray * historySearchStringsArray;

@end
