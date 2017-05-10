//
//  ViewController.m
//  drawText
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ViewController.h"
#import "ANTextView.h"
#import <libkern/OSAtomic.h>
#import "LWTextLayout.h"

@interface ViewController ()
@property (nonatomic, strong)ANTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    LWTextLayout *contentTextLayout = [[LWTextLayout alloc] init];
    contentTextLayout.text = @"asfasdasdasdasdasdasdasdasdsdfklajksdflajksdklfahsdjlkfhjasdjklfhjsakdfjbansdf";
    contentTextLayout.font = [UIFont systemFontOfSize:15.0f];
    contentTextLayout.textColor = [UIColor blackColor];
    contentTextLayout.boundsRect = CGRectMake(60.0f, 50.0f, self.view.frame.size.width - 80.f, MAXFLOAT);
    contentTextLayout.linespace = 2.0f;
    [contentTextLayout creatCTFrameRef];
    
    self.textView = [ANTextView new];
    self.textView.contentTextLayout = contentTextLayout;
    self.textView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
        self.textView.center = self.view.center;
//    self.textView.frame = self.view.bounds;
    self.textView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end