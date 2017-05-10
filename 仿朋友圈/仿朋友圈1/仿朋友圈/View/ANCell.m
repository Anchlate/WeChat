//
//  ANCell.m
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANCell.h"
#import "ANCellContainerView.h"
#import "ANDefine.h"

@interface ANCell ()<ANCellContainerViewDelegat>

@property (nonatomic, strong) CALayer *iconLayer;
@property (nonatomic, strong) ANCellContainerView *containerView;

@end


@implementation ANCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.containerView];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    
}

#pragma mark -Public
+ (ANCell *)cellWithTableView:(UITableView *)tableView {
    
    ANCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    if (!cell) cell = [[ANCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellID]];
    
    return cell;
}

+ (NSString *)cellID {
    
    return @"cell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -Getter
- (CALayer *)iconLayer {
    
    if (!_iconLayer) {
        _iconLayer = [CALayer layer];
        _iconLayer.contentsScale = [UIScreen mainScreen].scale;
        _iconLayer.contentsGravity = kCAGravityResizeAspect;
        _iconLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _iconLayer;
}

- (ANCellContainerView *)containerView {
    
    if (!_containerView) {
        _containerView = [[ANCellContainerView alloc]initWithFrame:CGRectZero];
        _containerView.delegate = self;
        _containerView.backgroundColor = [UIColor blueColor];
    }
    return _containerView;
}

@end