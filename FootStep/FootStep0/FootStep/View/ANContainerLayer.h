//
//  ANContainerLayer.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class ANFlag, ANContainerLayer;

@protocol ANContainerLayerDelegate <NSObject>

@required

/**
 *  将要开始绘制之前回调函数
 */
- (BOOL)willBeginAsyncDisplay:(ANContainerLayer *)layer;


/**
 *  异步绘制回调函数
 */
- (void)didAsyncDisplay:(ANContainerLayer *)layer context:(CGContextRef)context size:(CGSize)size;


@optional

/**
 *  绘制结束回调函数
 */
- (void)didFinishAsyncDisplay:(ANContainerLayer *)layer isFiniedsh:(BOOL) isFinished;


@end

@interface ANContainerLayer : CALayer

/**
 *  异步绘制Delegate
 */
@property (nonatomic,weak) id <ANContainerLayerDelegate>asyncDisplayDelegate;

/**
 *  Flag
 */
@property (nonatomic, strong, readonly) ANFlag* flag;


- (void)drawContent;

- (void)cleanUp;


@end
