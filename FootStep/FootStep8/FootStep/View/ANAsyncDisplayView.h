//
//  ANAsyncDisplayView.h
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANTextLayout.h"


@class ANAsyncDisplayView;

@protocol ANAsyncDisplayViewDelegate <NSObject>

@optional
/**
 *  点击链接回调
 *
 */
- (void)lwAsyncDicsPlayView:(ANAsyncDisplayView *)lwLabel didCilickedLinkWithfData:(id)data;

/**
 *  额外的绘制任务在这里实现
 *
 */
- (void)extraAsyncDisplayIncontext:(CGContextRef)context size:(CGSize)size;

@end

@interface ANAsyncDisplayView : UIView

@property (nonatomic,weak) id <ANAsyncDisplayViewDelegate> delegate;

/**
 *  存放文字排版的数组
 */
@property (nonatomic,copy) NSArray* layouts;

@end
