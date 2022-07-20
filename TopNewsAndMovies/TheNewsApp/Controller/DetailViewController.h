//
//  DetailViewController.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 15/07/22.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UITextView *movieDescription;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDate;
@property (weak, nonatomic) IBOutlet UICollectionView *genreCollectionView;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, retain) NSDictionary *movieDict;

- (IBAction)GetNotificationButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
