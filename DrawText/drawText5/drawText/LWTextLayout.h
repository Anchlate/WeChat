//
//  The MIT License (MIT)
//  Copyright (c) 2016 Wayne Liu <liuweiself@126.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//　　The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//
//  LWTextLayout.h
//  LWAsyncLayerDemo
//
//  Created by 刘微 on 16/2/1.
//  Copyright © 2016年 Wayne Liu. All rights reserved.
//  https://github.com/waynezxcv/LWAsyncDisplayView
//  See LICENSE for this sample’s licensing information
//


#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

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


@interface LWTextLayout : NSObject

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


#define kLWTextLinkAttributedName @"LWTextLinkAttributedName"

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
