//
//  NewsTableViewCell.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 11/07/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;


@end

NS_ASSUME_NONNULL_END
