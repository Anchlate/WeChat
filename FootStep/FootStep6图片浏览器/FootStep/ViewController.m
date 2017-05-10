//
//  ViewController.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ViewController.h"
#import "BLFootStep.h"
#import "ANFootStepCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *datasource;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gettingData];
}

#pragma mark -Delegate
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ANCellLayout* cellLayout = self.datasource[indexPath.row];
    
    ANFootStepCell *cell = [ANFootStepCell cellWithTableView:tableView];
    cell.layout = cellLayout;
    
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

#pragma mark -Private
- (void)gettingData {
    
    WEAKSELF(weakSelf);
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"footStepDataSource" ofType:@"plist"];
    NSArray *datasource = [NSArray arrayWithContentsOfFile:path];
    
    [BLFootStep getFootStepWithArray:datasource block:^(NSArray *footSteps) {
        
        for (BLFootStep *footStep in footSteps) {
            
            ANCellLayout *cellLayout = [[ANCellLayout alloc]initWithCDStatusModel:footStep];
            [self.datasource addObject:cellLayout];
            
        }
        
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark -Getter
- (NSMutableArray *)datasource {
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

@end
