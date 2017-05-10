//
//  ANCellContainerView.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANTextLayout, ANCellContainerView;

@protocol ANCellContainerViewDelegate <NSObject>

@optional
/**
 *  点击链接回调
 *
 */
- (void)cellContainerView:(ANCellContainerView *)lwLabel didCilickedLinkWithfData:(id)data;

/**
 *  额外的绘制任务在这里实现
 *
 */
- (void)extraAsyncDisplayIncontext:(CGContextRef)context size:(CGSize)size;

@end


@interface ANCellContainerView : UIView

@property (nonatomic,weak) id <ANCellContainerViewDelegate> delegate;

/**
 *  存放文字排版的数组
 */
@property (nonatomic,copy) NSArray* layouts;


@end
