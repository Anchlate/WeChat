
//
//  ANTextView.m
//  drawText
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANTextView.h"
#import "LWTextLayout.h"
#import "Layer.h"

@interface ANTextView ()<LayerDelegate>
{
    CGFloat width;
    
}


@end


@implementation ANTextView

+ (Class)layerClass {
    
    return [Layer class];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        
        self.layer.opaque = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        ((Layer *)self.layer).asynDelegate = self;
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [(Layer *)self.layer drawContent];
    
}

- (void)didAsyncDisplay:(Layer *)layer context:(CGContextRef)context size:(CGSize)size {
    
    [self.contentTextLayout drawInContext:context];
}

























- (void)drawContent {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawInContext:context];
}

- (void)drawInContext:(CGContextRef)context {
    @autoreleasepool {
        CGContextSaveGState(context);
        CGContextSetTextMatrix(context,CGAffineTransformIdentity);
        CGContextTranslateCTM(context, self.contentTextLayout.boundsRect.origin.x, self.contentTextLayout.boundsRect.origin.y);
        CGContextTranslateCTM(context, 0, self.contentTextLayout.boundsRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, - self.contentTextLayout.boundsRect.origin.x, - self.contentTextLayout.boundsRect.origin.y);
        CTFrameDraw(self.contentTextLayout.frame, context);
        CGContextRestoreGState(context);
        
    }
}

@end