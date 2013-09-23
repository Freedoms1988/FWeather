//
//  FWMainViewController.m
//  FWeather
//
//  Created by Freedoms on 13-7-8.
//  Copyright (c) 2013年 Freedoms. All rights reserved.
//

#import "FWMainViewController.h"


@interface FWMainViewController ()

@end

@implementation FWMainViewController
#pragma mark - ViewController Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10.0f, 10.0f, 300.0f, 44.0f);
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateAction{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/Weather/citycodeDB.sqlite"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFURLConnectionOperation *operation = [[AFURLConnectionOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [[paths objectAtIndex:0] stringByAppendingString:@"citycodeDB.sqlite"];
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filepath append:NO];
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        NSLog(@"%lld",totalBytesRead/totalBytesExpectedToRead);
//    }];
    [operation start];
}
@end
