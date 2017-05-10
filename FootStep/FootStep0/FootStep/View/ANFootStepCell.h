//
//  ANFootStepCell.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANCellLayout;

@interface ANFootStepCell : UITableViewCell

@property (nonatomic, retain) ANCellLayout* cellLayout;

+ (ANFootStepCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)cellID;

@end
