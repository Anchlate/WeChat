//
//  ANTextLayout.h
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "ANTextAttach.h"


/**
 *  垂直方向对齐方式
 */
typedef NS_ENUM(NSUInteger, LWVerticalAlignment){
    /**
     *  顶部对齐
     */
    LWVerticalAlignmentTop,
    /**
     *  居中
     */
    LWVerticalAlignmentCenter,
    /**
     *  底部对齐
     */
    LWVerticalAlignmentBottom,
};

@interface ANTextLayout : NSObject

/**
 *  文本内容，默认为nil
 */
@property (nonatomic,copy) NSString* text;

/**
 *  属性文本，默认为nil
 */
@property (nonatomic,strong) NSMutableAttributedString* attributedText;

/**
 *  文本颜色，默认为RGB(0,0,0,1)
 */
@property (nonatomic,strong) UIColor* textColor;

/**
 *  字体，默认为[UIFont systemFontOfSize:14.0f]
 */
@property (nonatomic,strong) UIFont* font;

/**
 *  行间距
 */
@property (nonatomic,assign) CGFloat linespace;

/**
 *  字间距
 */
@property (nonatomic, assign) unichar characterSpacing;

/**
 *  文本行数
 */
@property (nonatomic,assign) NSInteger numberOfLines;

/**
 *  水平方向对齐方式
 */
@property (nonatomic,assign) NSTextAlignment textAlignment;

/**
 *  垂直方向对齐方式
 */
@property (nonatomic,assign) LWVerticalAlignment veriticalAlignment;

/**
 *  下划线式样
 */
@property (nonatomic,assign) NSUnderlineStyle underlineStyle;

/**
 *  换行方式，默认为NSLineBreakByWordWrapping
 */
@property (nonatomic) NSLineBreakMode lineBreakMode;

/**
 *  ctFrameRef
 */
@property (nonatomic,assign) CTFrameRef frame;

/**
 *  文字高度
 */
@property (nonatomic,assign) CGFloat textHeight;

/**
 *  文字宽度
 *
 */
@property (nonatomic,assign) CGFloat textWidth;

/**
 * 计算后的文字绘制范围
 */
@property (nonatomic,assign) CGRect boundsRect;

/**
 *  存放附件的数组
 */
@property (nonatomic,strong) NSMutableArray* attachs;

/**
 *  是否自动适配宽度
 */
@property (nonatomic,assign,getter=isWidthToFit) BOOL widthToFit;

/**
 *  创建CTFrameRef
 *
 */
- (void)creatCTFrameRef;

/**
 *  绘制
 *
 */
- (void)drawInContext:(CGContextRef)context;

/**
 *  为指定位置的文本添加链接
 *
 */
- (void)addLinkWithData:(id)data
                inRange:(NSRange)range
              linkColor:(UIColor *)linkColor
         highLightColor:(UIColor *)highLightColor
         UnderLineStyle:(NSUnderlineStyle)underlineStyle;

/**
 *  用本地图片替换掉指定位置的文字
 *
 */
- (void)replaceTextWithImage:(UIImage *)image inRange:(NSRange)range;

/**
 *  用网络图片替换掉指定位置的文字
 *
 */
- (void)replaceTextWithImageURL:(NSURL *)URL inRange:(NSRange)range;


#define kLWTextLinkAttributedName @"LWTextLinkAttributedName"

@end
