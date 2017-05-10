//
//  ANFootStepCell.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANCellLayout.h"

@interface ANFootStepCell : UITableViewCell

@property (nonatomic,strong) ANCellLayout* layout;

+ (ANFootStepCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)cellID;

@end
