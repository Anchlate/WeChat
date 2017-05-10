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
#import "CALayer+WebCache.h"
#import "ANCellLayout.h"


@interface ANCell ()<ANCellContainerViewDelegat>

@property (nonatomic, strong) CALayer *iconLayer;
@property (nonatomic, copy) NSMutableArray *imageLayers;
@property (nonatomic, strong) ANCellContainerView *containerView;
@property (nonatomic,assign,getter=isNeedLayoutImageViews) BOOL needLayoutImageViews;

@end


@implementation ANCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.needLayoutImageViews = YES;
        [self.contentView addSubview:self.containerView];
        [self.containerView.layer addSublayer:self.iconLayer];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.layout.cellHeight);
    
    //
    [CATransaction begin];
    [CATransaction setDisableActions:YES];//设置是否启动隐式动画
    
    self.iconLayer.frame = self.layout.avatarPosition;
    if (self.isNeedLayoutImageViews) {
#warning message
//        [self resetImageLayers];
    }
    for (NSInteger i = 0; i < self.layout.imagePostionArray.count; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        imageLayer.frame = CGRectFromString([self.layout.imagePostionArray objectAtIndex:i]);
    }
    [CATransaction commit];
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

#pragma mark -Private
- (void)setupCell {
    
    // 用户头像
    [self.iconLayer sd_setImageWithURL:[NSURL URLWithString:self.layout.avatar]
                        placeholderImage:nil
                                 options:SDWebImageDelaySetContents];
    
    // 名字，内容，时间
    NSMutableArray* layouts = [[NSMutableArray alloc] init];
    [layouts addObject:self.layout.nameTextLayout];
    [layouts addObject:self.layout.contentTextLayout];
    [layouts addObject:self.layout.dateTextLayout];
    [layouts addObjectsFromArray:self.layout.commentTextLayouts];
    self.containerView.layouts = layouts;
   
//    [self setupImages];
}


#pragma mark -Setter
- (void)setLayout:(ANCellLayout *)layout {
    
    if (_layout == layout) return;
    
    if (_layout.imagePostionArray.count != layout.imagePostionArray.count) self.needLayoutImageViews = YES;
    else self.needLayoutImageViews = NO;
    
    _layout = layout;
    [self setupCell];
    
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

- (NSMutableArray *)imageLayers {
    
    if (_imageLayers) {
        
        _imageLayers = [[NSMutableArray alloc] initWithCapacity:9];
        
        for (NSInteger i = 0; i < 9; i ++) {
            
            CALayer* imageLayer = [CALayer layer];
            imageLayer.contentsScale = [UIScreen mainScreen].scale;
            imageLayer.contentsGravity = kCAGravityResizeAspectFill;
            imageLayer.masksToBounds = YES;
            [self.containerView.layer addSublayer:imageLayer];
            [_imageLayers addObject:imageLayer];
            
        }
    }
    return _imageLayers ;
}



@end