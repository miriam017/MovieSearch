//
//  MovieTableViewController.m
//  Movie
//
//  Created by Miriam on 2015/4/5.
//  Copyright (c) 2015年 Miriam. All rights reserved.
//

#import "MovieTableViewController.h"
#import <AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieTableViewController ()

@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self searchAPI:MOVIE_SEARCH_API_URL parameters:@{@"q":@"hobbit"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API
- (void)searchAPI:(NSString *)searchString parameters:(id)parameters {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:searchString
              parameters:parameters
                 success:^(NSURLSessionDataTask * __unused task, id JSON) {
                     [self apiResultProcess:JSON];
                     [self.tableView reloadData];
                 }
                 failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                     NSLog(@"Error: %@", error);
                 }];
}

- (void)apiResultProcess:(NSDictionary *)responseObject {
    moviesArray = [[NSMutableArray alloc] initWithArray:[responseObject valueForKeyPath:@"movies"]];
    NSLog(@"count=%li", moviesArray.count);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return moviesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"movieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *movie = (NSDictionary *) [moviesArray objectAtIndex:indexPath.row];
    
    UIImageView *posterImageView = (UIImageView *) [cell viewWithTag:101];
    UILabel *titleLabel = (UILabel *) [cell viewWithTag:102];
    UILabel *yearLabel = (UILabel *) [cell viewWithTag:103];
    UILabel *ratingLabel = (UILabel *) [cell viewWithTag:104];
    
//    NSLog(@"%li:title=%@ year=%@ rating=%@", (long)indexPath.row, [movie valueForKey:@"title"], [movie valueForKey:@"year"], [movie valueForKey:@"rating"]);
    titleLabel.text = [movie valueForKey:@"title"];
    yearLabel.text = [NSString stringWithFormat:@"%@", [movie valueForKey:@"year"] ];
    ratingLabel.text = [NSString stringWithFormat:@"%@", [movie valueForKey:@"rating"]];
    
    [posterImageView sd_setImageWithURL:[NSURL URLWithString:[[[movie valueForKey:@"poster"] valueForKey:@"urls"] valueForKey:@"w92"]]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
