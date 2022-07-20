//
//  CommonTableViewCell.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 13/07/22.
//

#import "CommonTableViewCell.h"
#import "APIHandler.h"
#import "CommonCollectionViewCell.h"
#import "WebKitViewController.h"
#import "DetailViewController.h"

@implementation CommonTableViewCell {
    
    __weak IBOutlet UILabel *lblTitle;
    
    BOOL isNewsTypeCell;
    NSInteger selectedIndex;
    
    NSArray *commonArticleArray;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.CommonCollectionView.dataSource = self;
    self.CommonCollectionView.delegate = self;
    
    [self.CommonCollectionView registerNib:[UINib nibWithNibName:@"CommonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CommonCollectionViewCell"];

}

- (void) prepareForReuse {
    [super prepareForReuse];
    commonArticleArray = nil;
    
}

- (void)updateTableViewCellForTitle:(NSString *)title withArray:(NSArray *)array isNewsType:(BOOL)isNews {
    
    lblTitle.text = title;
    commonArticleArray = array;
    isNewsTypeCell = isNews;
    [self.CommonCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void) openActionsheet {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Select an Option" message:@"Choose an option to display the page" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Open in Safari" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *commonArticleDict = commonArticleArray[selectedIndex];
        NSString *url = [commonArticleDict valueForKey:@"url"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
        
    }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Open in App" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary *commonArticleDict = commonArticleArray[selectedIndex];
        NSString *url = [commonArticleDict valueForKey:@"url"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebKitViewController *myVC = (WebKitViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webVC"];
        myVC.webUrl = url;
        [self.parentViewController.navigationController pushViewController:myVC animated:YES];
        
    }];

    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }];

    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.parentViewController presentViewController:ac animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return commonArticleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonCollectionViewCell *cell = (CommonCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CommonCollectionViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[CommonCollectionViewCell alloc] init];
    }
    
    NSDictionary *commonArticleDict = commonArticleArray[indexPath.row];
    if(isNewsTypeCell) {
        NSString *url = [commonArticleDict valueForKey:@"urlToImage"];
     cell.wsjImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
       cell.wsjLabel.text = [commonArticleDict valueForKey:@"title"];
    } else {
        NSString *imageLink = @"https://image.tmdb.org/t/p/w500";
        NSString *posterLink = [commonArticleDict valueForKey:@"poster_path"];
        NSString *url = [NSString stringWithFormat:@"%@%@", imageLink, posterLink];
        
        cell.wsjImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        cell.wsjLabel.text = [commonArticleDict valueForKey:@"title"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedIndex = indexPath.row;
    
    if(isNewsTypeCell) {
    [self openActionsheet];
    } else {
        NSDictionary *commonArticleDict = commonArticleArray[indexPath.row];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailViewController *detailVC = (DetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"movieVC"];
        detailVC.movieDict = commonArticleDict;
        [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}

@end
