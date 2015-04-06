//
//  MovieTableViewController.h
//  Movie
//
//  Created by Miriam on 2015/4/5.
//  Copyright (c) 2015年 Miriam. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MOVIE_SEARCH_API_URL @"http://api.movies.io/movies/search"

@interface MovieTableViewController : UITableViewController {
    NSMutableArray *moviesArray;
}
@end
