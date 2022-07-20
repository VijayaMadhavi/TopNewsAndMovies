//
//  WSJCollectionViewCell.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 13/07/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *wsjImageView;
@property (weak, nonatomic) IBOutlet UILabel *wsjLabel;

@end

NS_ASSUME_NONNULL_END
