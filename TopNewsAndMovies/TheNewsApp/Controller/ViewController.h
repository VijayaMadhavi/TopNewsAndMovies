//
//  ViewController.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 08/07/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end

