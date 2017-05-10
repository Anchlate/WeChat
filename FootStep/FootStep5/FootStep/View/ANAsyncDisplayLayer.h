//
//  ANAsyncDisplayLayer.h
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ANFlag.h"

@class ANAsyncDisplayLayer;

@protocol ANAsyncDisplayLayerDelegate <NSObject>

@required

/**
 *  将要开始绘制之前回调函数
 */
- (BOOL)willBeginAsyncDisplay:(ANAsyncDisplayLayer *)layer;


/**
 *  异步绘制回调函数
 */
- (void)didAsyncDisplay:(ANAsyncDisplayLayer *)layer context:(CGContextRef)context size:(CGSize)size;


@optional

/**
 *  绘制结束回调函数
 */
- (void)didFinishAsyncDisplay:(ANAsyncDisplayLayer *)layer isFiniedsh:(BOOL) isFinished;


@end

@interface ANAsyncDisplayLayer : CALayer

/**
 *  异步绘制Delegate
 */
@property (nonatomic,weak) id <ANAsyncDisplayLayerDelegate>asyncDisplayDelegate;

/**
 *  Flag
 */
@property (nonatomic,strong,readonly) ANFlag* flag;


- (void)drawContent;

- (void)cleanUp;

@end
