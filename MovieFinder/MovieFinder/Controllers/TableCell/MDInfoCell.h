//
//  MDInfoCell.h
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *ratingPGLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *studioLabel;

@end
