//
//  CommonTableViewCell.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 13/07/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonTableViewCell : UITableViewCell <UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *CommonCollectionView;

@property (nonatomic, retain) UIViewController *parentViewController;


- (void)updateTableViewCellForTitle:(NSString *)title withArray:(NSArray *)array isNewsType:(BOOL)isNews;

@end

NS_ASSUME_NONNULL_END
