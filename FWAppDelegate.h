//
//  FWAppDelegate.h
//  FWeather
//
//  Created by Freedoms on 13-7-1.
//  Copyright (c) 2013年 Freedoms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWNavigationViewController.h"
#import "FWMainViewController.h"
#import "AFNetworkActivityIndicatorManager.h"

@class FWMainViewController;

@interface FWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FWMainViewController *viewController;

@end
