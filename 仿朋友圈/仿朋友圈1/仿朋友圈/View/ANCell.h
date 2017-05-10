//
//  ANCell.h
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+WebCache.h"

@interface ANCell : UITableViewCell

+ (ANCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)cellID;

@end
