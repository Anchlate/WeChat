//
//  Layer.h
//  drawText
//
//  Created by Qianrun on 16/12/1.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class Layer;

@protocol LayerDelegate <NSObject>

/**
 *  异步绘制回调函数
 */
- (void)didAsyncDisplay:(Layer *)layer context:(CGContextRef)context size:(CGSize)size;

@end

@interface Layer : CALayer

@property (nonatomic, assign) id<LayerDelegate> asynDelegate;

- (void)drawContent;

@end
