//
//  ViewController.m
//  LWAsyncDisplayViewDemo
//
//  Created by 刘微 on 16/3/16.
//  Copyright © 2016年 WayneInc. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"

#import "LWDefine.h"
#import "CellLayout.h"
#import "CDStatus.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonnull,strong) NSArray* fakeDatasource;

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,assign,getter=isNeedRefresh) BOOL needRefresh;

@end

const CGFloat kRefreshBoundary = 170.0f;

@implementation ViewController

#pragma mark - ViewControllerLifeCycle

- (void)loadView {
    [super loadView];
    [self setup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshBegin];
}

- (void)setup {
    self.needRefresh = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary* attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationItem.title = @"朋友圈";
}

#pragma mark - Actions

/**
 *  点击链接
 *
 */
- (void)tableViewCell:(TableViewCell *)cell didClickedLinkWithData:(id)data {
    UIViewController* vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = data;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cellIdentifier";
    TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CellLayout* cellLayout = self.dataSource[indexPath.row];
    cell.layout = cellLayout;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellLayout* cellLayout = self.dataSource[indexPath.row];
    return cellLayout.cellHeight;
}

- (void)refreshBegin {
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.tableView.contentInset = UIEdgeInsetsMake(kRefreshBoundary, 0.0f, 0.0f, 0.0f);
        
    } completion:^(BOOL finished) {
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isNeedRefresh) {
                [self downloadData];
            } else {
                
                [UIView animateWithDuration:0.35f animations:^{
                    self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
                } completion:^(BOOL finished) {
                    self.needRefresh = NO;
                }];
            }
        });
    }];
}


- (void)downloadData {
    
    CDStatus *status = [CDStatus new];
    
    // avatar
    status.avatar = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1829483361/50/5753078359/1"];
    
    // name
    status.name = @"SIZE潮流生活";
    
    // conetent
    status.content = @"近日[心]，adidas Originals为经典鞋款Stan Smith打造Primeknit版本，并带来全新的“OG”系列。简约的鞋身采用白色透气Primeknit针织材质制作，再将Stan Smith代表性的绿、红、深蓝三个元年色调融入到鞋舌和后跟点缀，最后搭载上米白色大底来保留其复古风味。据悉该鞋款将在今月登陆全球各大adidas Originals指定店舖。";
    
    // imgs
    status.imgs = @[
                      @"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hgxij20lo0egwgc.jpg",
                      @"http://ww3.sinaimg.cn/mw690/6d0bb361gw1f2jim2hsg6j20lo0egwg2.jpg",
                      @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2d7nfj20lo0eg40q.jpg",
                      @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2hka3j20lo0egdhw.jpg",
                      @"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hq61j20lo0eg769.jpg"
                      ];
    
    // date
    status.date = [NSDate date];
    
    // commentList
    NSDictionary *comment1 = @{
                               @"content" : @"内容",
                               @"from" : @"来自",
                               @"to" : @"A1"
                               };
    
    NSDictionary *comment2 = @{
                               @"content" : @"内容2",
                               @"from" : @"来自2",
                               @"to" : @"A2"
                               };
    
    NSDictionary *comment3 = @{
                               @"content" : @"内容3",
                               @"from" : @"来自3",
                               @"to" : @"A3"
                               };
    
    //status.commentList = @[comment1, comment2, comment3];
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithObject:status];
    
    for (int i = 0 ; i < 5; i++) {
        [mutArr addObjectsFromArray:mutArr];
    }
    
    
    for (CDStatus* status in mutArr) {
        CellLayout* cellLayout = [[CellLayout alloc]
                                  initWithCDStatusModel:status];
        [self.dataSource addObject:cellLayout];
    }
    
    [self refreshComplete];
}

- (void)refreshComplete {
    
    [UIView animateWithDuration:0.35f animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
        self.needRefresh = NO;
    }];
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.decelerationRate = 1.0f;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
