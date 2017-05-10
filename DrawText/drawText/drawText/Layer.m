
//
//  Layer.m
//  drawText
//
//  Created by Qianrun on 16/12/1.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "Layer.h"
#import <UIKit/UIKit.h>
#import "CALayer+LazySetContents.h"
#import <libkern/OSAtomic.h>

static dispatch_queue_t GetAsyncDisplayQueue() {
#define MAX_QUEUE_COUNT 16
    static int queueCount;
    static dispatch_queue_t queues[MAX_QUEUE_COUNT];
    static dispatch_once_t onceToken;
    static int32_t counter = 0;
    dispatch_once(&onceToken, ^{
        queueCount = (int)[NSProcessInfo processInfo].activeProcessorCount;
        queueCount = queueCount < 1 ? 1 : queueCount > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : queueCount;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            for (NSUInteger i = 0; i < queueCount; i++) {
                dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
                queues[i] = dispatch_queue_create("com.waynezxcv.AsyncDisplay", attr);
            }
        } else {
            for (NSUInteger i = 0; i < queueCount; i++) {
                queues[i] = dispatch_queue_create("com.waynezxcv.AsyncDisplay", DISPATCH_QUEUE_SERIAL);
                dispatch_set_target_queue(queues[i], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
            }
        }
    });
    int32_t cur = OSAtomicIncrement32(&counter);
    if (cur < 0) cur = - cur;
    return queues[(cur) % queueCount];
#undef MAX_QUEUE_COUNT
}



@implementation Layer

- (id)init {
    
    if (self = [super init]) {
        
    }
    return self;
}


#pragma mark -Public
- (void)drawContent {
    [self asynDraw];
}

- (void)asynDraw {
    
    CGSize size = self.bounds.size;
    BOOL opaque = self.opaque;
    CGFloat scale = self.contentsScale;
    
    dispatch_async(GetAsyncDisplayQueue(), ^{
    
        UIGraphicsBeginImageContextWithOptions(size,opaque, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context == NULL) {
            NSLog(@"context is NULL");
            return;
        }
    
        [self.asynDelegate didAsyncDisplay:self context:context size:self.bounds.size];
        UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
        CGImageRef content = screenshotImage.CGImage;
    
        UIGraphicsEndImageContext();
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lazySetContent:(__bridge id)content];
        });
    });
}

@end
