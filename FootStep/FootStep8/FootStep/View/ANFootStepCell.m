
//
//  ANFootStepCell.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANFootStepCell.h"
#import "BLFootStep.h"
#import "ANAsyncDisplayView.h"
#import "CALayer+WebCache.h"

@interface ANFootStepCell ()<ANAsyncDisplayViewDelegate>
@property (nonatomic,strong) CALayer* avatarLayer;
@property (nonatomic,strong) NSMutableArray* imageLayers;
@property (nonatomic,strong) ANAsyncDisplayView* asyncDisplayView;
@property (nonatomic,assign,getter=isNeedLayoutImageViews) BOOL needLayoutImageViews;

@end

@implementation ANFootStepCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.asyncDisplayView];
        [self.asyncDisplayView.layer addSublayer:self.avatarLayer];
    }
    return self;
}

- (void)setLayout:(ANCellLayout *)layout {
    
    if (_layout == layout) {
        return;
    }
    
    if (_layout.imagePostionArray.count != layout.imagePostionArray.count) {
        self.needLayoutImageViews = YES;
    }
    
    else {
        self.needLayoutImageViews = NO;
    }
    
    _layout = layout;
    [self setupCell];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.asyncDisplayView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.layout.cellHeight);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];//设置是否启动隐式动画
    self.avatarLayer.frame = self.layout.avatarPosition;
    if (self.isNeedLayoutImageViews) {
        [self resetImageLayers];
    }
    for (NSInteger i = 0; i < self.layout.imagePostionArray.count; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        imageLayer.frame = CGRectFromString([self.layout.imagePostionArray objectAtIndex:i]);
    }
    [CATransaction commit];
}

- (void)setupCell {
    
    [self.avatarLayer sd_setImageWithURL:[NSURL URLWithString:self.layout.footstep.memberlogo]
                        placeholderImage:nil
                                 options:SDWebImageDelaySetContents];
    
    NSMutableArray* layouts = [[NSMutableArray alloc] init];
    [layouts addObject:self.layout.nameTextLayout];
    [layouts addObject:self.layout.contentTextLayout];
    [layouts addObject:self.layout.deviceTextLayout];
    [layouts addObjectsFromArray:self.layout.commentTextLayouts];
    self.asyncDisplayView.layouts = layouts;
    [self setupImages];
}

- (void)extraAsyncDisplayIncontext:(CGContextRef)context size:(CGSize)size {
    //绘制头像外框
    CGContextAddRect(context,self.layout.avatarPosition);
    CGContextMoveToPoint(context, 0.0f, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextSetLineWidth(context, 0.3f);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    //绘制图片背景
    for (NSInteger i = 0; i < self.layout.imagePostionArray.count; i ++) {
        CGContextAddRect(context, CGRectFromString(self.layout.imagePostionArray[i]));
        CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextFillPath(context);
    }
    //绘制菜单按钮
    [self _drawImage:[UIImage imageNamed:@"menu"] rect:_layout.menuPosition context:context];
    
    //绘制评论背景
    UIImage*commentBgImage = [[UIImage imageNamed:@"comment"] stretchableImageWithLeftCapWidth:40.0f topCapHeight:15.0f];
    [commentBgImage drawInRect:self.layout.commentBgPosition];
}

- (void)_drawImage:(UIImage *)image rect:(CGRect)rect context:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
}

- (void)resetImageLayers {
    for (NSInteger i = 0; i < 9; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        imageLayer.frame = CGRectZero;
    }
}

- (void)setupImages {
    
    for (NSInteger i = 0; i < self.layout.imagePostionArray.count; i ++) {
        CALayer* imageLayer = [self.imageLayers objectAtIndex:i];
        
        BLEventGallery *gallery = [self.layout.footstep.eventgallery objectAtIndex:i];
        NSString* img = gallery.smallImgURL;
        NSLog(@"..........small:%@", img);
        [imageLayer sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil options:SDWebImageDelaySetContents];
    }
}

#pragma mark - Getter

- (ANAsyncDisplayView *)asyncDisplayView {
    if (!_asyncDisplayView) {
        _asyncDisplayView = [[ANAsyncDisplayView alloc] initWithFrame:CGRectZero];
        _asyncDisplayView.delegate = self;
        _asyncDisplayView.backgroundColor = [UIColor whiteColor];
    }
    return _asyncDisplayView;
}

- (NSMutableArray *)imageLayers {
    
    if (_imageLayers) {
        return _imageLayers;
    }
    _imageLayers = [[NSMutableArray alloc] initWithCapacity:9];
    for (NSInteger i = 0; i < 9; i ++) {
        CALayer* imageLayer = [CALayer layer];
        imageLayer.contentsScale = [UIScreen mainScreen].scale;
        imageLayer.contentsGravity = kCAGravityResizeAspectFill;
        imageLayer.masksToBounds = YES;
        [self.asyncDisplayView.layer addSublayer:imageLayer];
        [_imageLayers addObject:imageLayer];
    }
    return _imageLayers ;
}

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







#pragma mark -Setter


#pragma mark -Getter


@end
