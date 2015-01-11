//
//  MoviesDetailViewController.m
//  MovieFinder
//
//  Created by Ajinkya Shelar on 11/01/15.
//  Copyright (c) 2015 Ajinkya Shelar. All rights reserved.
//

#import "MoviesDetailViewController.h"
#import "NetworkEngine.h"
#import "Parser.h"
#import "UIImageView+WebCache.h"
#import "MDImageCell.h"
#import "MDInfoCell.h"
#import "MDSynopsisCell.h"
#import "MDAttrisCell.h"


@implementation MoviesDetailViewController
@synthesize movieID;
@synthesize movieDetailObj;
@synthesize tableViewDetails;
@synthesize synopsisHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDetails.hidden = YES;
    [self getMoviesDetailsForID:movieID];
}


#pragma mark - Search Movie API

-(void)getMoviesDetailsForID:(NSString*)movieIDN
{
    [[NetworkEngine sharedAPIManager] getMoviesDetailsForId:movieIDN onCompletion:^(AFHTTPRequestOperation *operation, id response) {
        
        movieDetailObj = [Parser parseSearchMovieDetails:response];
        
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           tableViewDetails.hidden = NO;
                           self.title = movieDetailObj.title;
                           [tableViewDetails reloadData];                           
                           
                       });

    } onError:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"Network Problem");
    }];
    
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return movieDetailObj.genres.count;
            break;
        case 4:
            return movieDetailObj.abridged_directors.count;
            break;
        case 5:
            return movieDetailObj.abridged_cast.count;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            MDImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDImageCell" forIndexPath:indexPath];
            
            [cell.imageViewFull sd_setImageWithURL:[NSURL URLWithString:movieDetailObj.originalImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
        case 1:
        {
            MDInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDInfoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (movieDetailObj.title.length != 0)
                cell.titleLable.text = movieDetailObj.title;
            if (movieDetailObj.studio.length != 0)
                cell.studioLabel.text = [NSString stringWithFormat:@"Studio : %@", movieDetailObj.studio];
            if (movieDetailObj.mpaa_rating.length != 0)
                cell.ratingPGLabel.text = [NSString stringWithFormat:@"Ratings : %@", movieDetailObj.mpaa_rating];
            if (movieDetailObj.release_dates.length != 0)
                cell.releaseDateLabel.text = [NSString stringWithFormat:@"Release Date : %@", movieDetailObj.release_dates];
            if (movieDetailObj.year != 0)
                cell.yearLabel.text = [NSString stringWithFormat:@"Year : %d", movieDetailObj.year];
            if (movieDetailObj.runtime != 0)
                cell.runtimeLabel.text = [NSString stringWithFormat:@"Runtime : %d min", movieDetailObj.runtime];
            
            return cell;
            break;
        }

        case 2:
        {
            MDSynopsisCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDSynopsisCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (movieDetailObj.synopsis.length != 0)
            {
                cell.synopsisLabel.text = movieDetailObj.synopsis;
                NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:movieDetailObj.synopsis];
                CGFloat heightOfcell = [self height:str];
                cell.synopsisLabel.frame = CGRectMake(10, 10, 300, heightOfcell);

            }
            
            return cell;
            break;
        }
        case 3:
        {
            MDAttrisCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDAttrisCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (movieDetailObj.genres.count != 0)
            {
                cell.lableAttri.text = movieDetailObj.genres[indexPath.row];
            }
            
            return cell;
            break;
        }
        case 4:
        {
            MDAttrisCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDAttrisCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (movieDetailObj.abridged_directors.count != 0)
            {
                NSDictionary *director = movieDetailObj.abridged_directors[indexPath.row];
                cell.lableAttri.text = [director valueForKey:@"name"];
            }
            
            return cell;
            break;
        }
        case 5:
        {
            MDAttrisCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MDAttrisCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (movieDetailObj.abridged_cast.count != 0)
            {
                NSDictionary *cast = movieDetailObj.abridged_cast[indexPath.row];
                cell.lableAttri.text = [cast valueForKey:@"name"];
            }
            
            return cell;
            break;
        }
            
        default:
            return 0;
            break;
    }
}

-(float)height :(NSMutableAttributedString*)string
{
    
    NSAttributedString *attributedText = string;
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){300, MAXFLOAT}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];//you need to specify the some width, height will be calculated
    CGSize requiredSize = rect.size;
    return requiredSize.height+60; //finally u return your height
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 180;
            break;
        case 1:
            return 175;
            break;
        case 2:
        {
            if(movieDetailObj.synopsis.length != 0)
            {
                NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:movieDetailObj.synopsis];
                CGFloat heightOfcell = [self height:str];
                NSLog(@"heightOfcell: %f", heightOfcell);
                 return heightOfcell+20;
            }
            else
                return 0;
            break;
        }
            
            
        default:
            return 44;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {

        case 2:
            if(movieDetailObj.synopsis.length != 0)
                return 44;
            else
                return 0;
            break;
        case 3:
            return 44;
            break;
        case 4:
            return 44;
            break;
        case 5:
            return 44;
            break;
            
        default:
            return 0;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
            
        case 2:
            return @"Synposis :";
            break;
        case 3:
            return @"Genres :";
            break;
        case 4:
            return @"Directors :";
            break;
        case 5:
            return @"Cast :";
            break;
            
        default:
            return @"";
            break;
    }
}

@end
