//
//  ViewController.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 08/07/22.
//

#import "ViewController.h"
#import "NewsTableViewCell.h"
#import "CommonTableViewCell.h"
#import "APIHandler.h"

@interface ViewController () {
    
    NSArray *arrWSJHeadlines;
    NSArray *arrTopRatedMovies;
    NSArray *arrPopularMovies;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Top Stories";
    
    [self.newsTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"newsCell"];
    
    [self.newsTableView registerNib:[UINib nibWithNibName:@"CommonTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"commonCell"];
    
    
    
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    
    arrWSJHeadlines = [APIHandler getWSJHeadlines];
    arrTopRatedMovies = [APIHandler getTopRatedMovies];
    arrPopularMovies = [APIHandler getPopularMovies];
    
    [self.newsTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsCell"];
    }
    return cell;
   } else {
       CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"commonCell"];
       if (cell == nil) {
           cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commonCell"];
       }
       cell.parentViewController = self;
       if(indexPath.row == 1) {
           [cell updateTableViewCellForTitle:@"Wall Street Journal" withArray:arrWSJHeadlines isNewsType:YES];
       } else if(indexPath.row == 2) {
           [cell updateTableViewCellForTitle:@"Top Rated Movies" withArray:arrTopRatedMovies isNewsType:NO];
       }  else if(indexPath.row == 3) {
           [cell updateTableViewCellForTitle:@"Popular Movies" withArray:arrPopularMovies isNewsType:NO];
       }
       return cell;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0;
}

@end
