//
//  NewsTableViewCell.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 11/07/22.
//

#import "NewsTableViewCell.h"
#import "APIHandler.h"
#import "NewsCollectionViewCell.h"

@implementation NewsTableViewCell{

NSArray *newsArticleArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.newsCollectionView.dataSource = self;
    self.newsCollectionView.delegate = self;
    
    newsArticleArray = [APIHandler getTopHeadlines];
    
    [self.newsCollectionView reloadData];
    
    [self.newsCollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"newsCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return newsArticleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCollectionViewCell *cell = (NewsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[NewsCollectionViewCell alloc] init];
    }
    
   NSDictionary *newsArticleDict = newsArticleArray[indexPath.row];
    NSString *url = [newsArticleDict valueForKey:@"urlToImage"];
  cell.newsImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}


@end
