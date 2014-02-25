//
//  AboutViewController.h
//  Bullseye
//
//  Created by Randy Ram on 1/30/14.
//  Copyright (c) 2014 Randy Ram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIWebView *webView;
-(IBAction) close;
@end
