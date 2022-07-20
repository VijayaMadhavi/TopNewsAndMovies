//
//  WebKitViewController.h
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 16/07/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebKitViewController : UIViewController

@property (weak, nonatomic) WKWebView *newsWebKitView;
@property (nonatomic, retain) NSString *webUrl;


- (void) displayPageForUrl;
@end

NS_ASSUME_NONNULL_END
