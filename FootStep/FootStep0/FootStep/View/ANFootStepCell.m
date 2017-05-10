
//
//  ANFootStepCell.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANFootStepCell.h"
#import "ANCellLayout.h"
#import "ANCellContainerView.h"
#import "BLFootStep.h"

@interface ANFootStepCell ()<ANCellContainerViewDelegate>

@property (nonatomic,strong) CALayer* avatarLayer;
@property (nonatomic,strong) NSMutableArray* imageLayers;
@property (nonatomic,strong) ANCellContainerView* containerView;
@property (nonatomic,assign,getter=isNeedLayoutImageViews) BOOL needLayoutImageViews;

@end

@implementation ANFootStepCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.needLayoutImageViews = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.containerView];
        [self.containerView.layer addSublayer:self.avatarLayer];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.containerView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.cellLayout.cellHeight);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];//设置是否启动隐式动画
    self.avatarLayer.frame = self.cellLayout.avatarPosition;
    if (self.isNeedLayoutImageViews) {
        [self resetImageLayers];
    }
    for (NSInteger i = 0; i < self.cellLayout.imagePostionArray.count; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        imageLayer.frame = CGRectFromString([self.cellLayout.imagePostionArray objectAtIndex:i]);
    }
    [CATransaction commit];
}


#pragma mark -Public
+ (ANFootStepCell *)cellWithTableView:(UITableView *)tableView {
    
    ANFootStepCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    if (!cell) cell = [[ANFootStepCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellID]];
    
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
    
    // 头像
    [self.avatarLayer sd_setImageWithURL:[NSURL URLWithString:self.cellLayout.footStep.memberlogo]
                        placeholderImage:nil
                                 options:SDWebImageDelaySetContents];
    
    
    NSMutableArray* layouts = [[NSMutableArray alloc] init];
    
    [layouts addObject:self.cellLayout.nameTextLayout];
    [layouts addObject:self.cellLayout.contentTextLayout];
    [layouts addObject:self.cellLayout.dateTextLayout];
    [layouts addObjectsFromArray:self.cellLayout.commentTextLayouts];
    self.containerView.layouts = layouts;
    [self setupImages];
}

- (void)setupImages {
    
    for (NSInteger i = 0; i < self.cellLayout.imagePostionArray.count; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        
        BLEventGallery *gallery = [self.cellLayout.footStep.eventgallery objectAtIndex:i];
        NSString* img = gallery.smallImgURL;
        NSLog(@"..........:%@", img);
        [imageLayer sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil options:SDWebImageDelaySetContents];
    }
}

- (void)resetImageLayers {
    for (NSInteger i = 0; i < 9; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        imageLayer.frame = CGRectZero;
    }
}


#pragma mark -Setter
- (void)setCellLayout:(ANCellLayout *)cellLayout {
    
    if (_cellLayout == cellLayout) return;
    
    if (_cellLayout.imagePostionArray.count != cellLayout.imagePostionArray.count) {
        self.needLayoutImageViews = YES;
    }
    else {
        self.needLayoutImageViews = NO;
    }
    
    _cellLayout = cellLayout;
    
    [self setupCell];
    
}

#pragma mark -Getter
- (CALayer *)avatarLayer {
    if (_avatarLayer) {
        return _avatarLayer;
    }
    _avatarLayer = [CALayer layer];
    _avatarLayer.contentsScale = [UIScreen mainScreen].scale;
    _avatarLayer.contentsGravity = kCAGravityResizeAspect;
    _avatarLayer.backgroundColor = [UIColor redColor].CGColor;
    return _avatarLayer;
}

- (ANCellContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[ANCellContainerView alloc]initWithFrame:CGRectZero];
        _containerView.delegate = self;
    }
    return _containerView;
}

- (NSMutableArray *)imageLayers {
    
    if (!_imageLayers) {
        
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