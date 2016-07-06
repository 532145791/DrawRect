//
//  ViewController.m
//  DrawRect
//
//  Created by 超冷 on 16/6/28.
//  Copyright © 2016年 超冷. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestView *tv = [[TestView alloc] initWithFrame:CGRectMake(50, 50, 300, 199)];
    
    tv.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tv];
}

@end
