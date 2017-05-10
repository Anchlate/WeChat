//
//  ANCell.h
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANCellLayout;

@interface ANCell : UITableViewCell

@property (nonatomic, retain)ANCellLayout *layout;

+ (ANCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)cellID;

@end