//
//  WSJCollectionViewCell.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 13/07/22.
//

#import "CommonCollectionViewCell.h"

@implementation CommonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.wsjImageView.image = [UIImage imageNamed:@""];
    self.wsjLabel.text = @"";
}

@end
