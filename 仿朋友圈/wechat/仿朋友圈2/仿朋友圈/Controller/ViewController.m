//
//  ViewController.m
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ViewController.h"
#import "ANCell.h"
#import <libkern/OSAtomic.h>
#import "ANCellLayout.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *datasource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 10; i++) {
        ANCellLayout *layout = [ANCellLayout new];
        [self.datasource addObject:layout];
    }   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ANCellLayout *layout = self.datasource[indexPath.row];
    
    ANCell *cell = [ANCell cellWithTableView:tableView];
    cell.layout = layout;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ANCellLayout* cellLayout = self.datasource[indexPath.row];
    return cellLayout.cellHeight;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Getter
- (NSMutableArray *)datasource {
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

@end