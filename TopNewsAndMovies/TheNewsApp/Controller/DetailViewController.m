//
//  DetailViewController.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 15/07/22.
//

#import "DetailViewController.h"
#import "APIHandler.h"
#import "GenreCollectionViewCell.h"
#import "StarRatingView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    
    NSArray *genreArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.genreCollectionView.dataSource = self;
    self.genreCollectionView.delegate = self;
    [self.genreCollectionView registerNib:[UINib nibWithNibName:@"GenreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"genreCell"];

    [self getGenreDetailFromServer];
    
    [self showMovieDetails];
    
    [self checkNotification];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            // Notifications not allowed
        }
    }];
}

- (void)checkNotification {
    //  how to get all pending notification
    
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *requests){NSLog(@"requests: %@", requests);}];

    //  traverse the array of notification
    //  request.content.userinfo compare with [_movieDict id"]
    //  request.trigger.nexttriggerDate
    //  show date as string
}

- (void) showMovieDetails {
    NSString *imageLink = @"https://image.tmdb.org/t/p/w500";
    NSString *posterLink = [_movieDict valueForKey:@"poster_path"];
    NSString *url = [NSString stringWithFormat:@"%@%@", imageLink, posterLink];
    self.movieImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    self.movieTitle.text = [_movieDict valueForKey:@"title"];
    self.movieDescription.text = [_movieDict valueForKey:@"overview"];
    self.movieReleaseDate.text = [_movieDict valueForKey:@"release_date"];
    
    [self configureStarRating];
    
}

- (void)getGenreDetailFromServer {
    genreArray =  [APIHandler getGenreWithMovieId:[_movieDict valueForKey:@"id"]];
    [self.genreCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return genreArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *genreDict = [genreArray objectAtIndex:indexPath.row];
    
    GenreCollectionViewCell *cell = (GenreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"genreCell" forIndexPath:indexPath];
    cell.genreLabel.text = [genreDict valueForKey:@"name"];
    return cell;
}

-(void) configureStarRating {
    
    StarRatingViewConfiguration *conf = [[StarRatingViewConfiguration alloc] init];
    conf.rateEnabled = YES;
    conf.starWidth = 40.0f;
    conf.fullImage = @"ic_starwhite.png";
    conf.halfImage = @"ic_starwhitehalf.png";
    conf.emptyImage = @"ic_starwhiteept";
    
    StarRatingView *ratingView = [[StarRatingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.starView.frame.size.height) configuration:conf];
    ratingView.backgroundColor = [UIColor redColor];
    NSString *stars = [_movieDict valueForKey:@"vote_average"];
    float floatStars = [stars floatValue];
    ratingView.rating = ceil(floatStars/2);
    
   
   [self.starView addSubview:ratingView];
}

- (IBAction)GetNotificationButton:(id)sender {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
      if (!granted) {
        NSLog(@"Something went wrong");
      }
    }];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Local Notification";
    content.body = @"This is your scheduled notification";
    content.sound = [UNNotificationSound defaultSound];
    
    NSDictionary *userData = @{@"movieId": [_movieDict valueForKey:@"id"]};
    content.userInfo = userData;
    
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear+NSCalendarUnitMonth+NSCalendarUnitDay+NSCalendarUnitHour+NSCalendarUnitMinute+NSCalendarUnitSecond fromDate:self.datePicker.date];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
    
    NSString *identifier = @"UYLLocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Something went wrong: %@",error);
      }
    }];
    
}
@end
