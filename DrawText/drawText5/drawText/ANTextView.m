
//
//  ANTextView.m
//  drawText
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANTextView.h"
#import "LWTextLayout.h"
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
                queues[i] = dispatch_queue_create("co", attr);
            }
        } else {
            for (NSUInteger i = 0; i < queueCount; i++) {
                queues[i] = dispatch_queue_create("co", DISPATCH_QUEUE_SERIAL);
                dispatch_set_target_queue(queues[i], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
            }
        }
    });
    int32_t cur = OSAtomicIncrement32(&counter);
    if (cur < 0) cur = - cur;
    return queues[(cur) % queueCount];
#undef MAX_QUEUE_COUNT
}

@interface ANTextView ()
{
    CGFloat width;
}

@end


@implementation ANTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        
        self.layer.opaque = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self asynDraw];
    
}

- (void)asynDraw {
    
    CGSize size = self.layer.bounds.size;
    BOOL opaque = self.layer.opaque;
    CGFloat scale = self.layer.contentsScale;
    
    dispatch_async(GetAsyncDisplayQueue(), ^{
        
        UIGraphicsBeginImageContextWithOptions(size,opaque, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context == NULL) {
            NSLog(@"context is NULL");
            return;
        }
        
        [self.contentTextLayout drawInContext:context];
        
        UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
        CGImageRef content = screenshotImage.CGImage;
        
        UIGraphicsEndImageContext();
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.layer setContents:(__bridge id _Nullable)(content)];
            
        });
    });
}

@end
