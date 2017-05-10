



//
//  ANCellContainerView.m
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANCellContainerView.h"
#import "LWAsyncDisplayLayer.h"
#import "LWRunLoopObserver.h"
#import "ANTextLayout.h"

@interface ANCellContainerView ()<LWAsyncDisplayLayerDelegate>

@end

@implementation ANCellContainerView

+ (Class)layerClass {
    return [LWAsyncDisplayLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.opaque = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        ((LWAsyncDisplayLayer *)self.layer).asyncDisplayDelegate = self;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [(LWAsyncDisplayLayer *)self.layer cleanUp];
    [(LWAsyncDisplayLayer *)self.layer drawContent];
}

#pragma mark -Delegate
#pragma mark - LWAsyncDisplayLayerDelegate
- (BOOL)willBeginAsyncDisplay:(LWAsyncDisplayLayer *)layer {
    return YES;
}

- (void)didAsyncDisplay:(LWAsyncDisplayLayer *)layer context:(CGContextRef)context size:(CGSize)size {
    
    for (ANTextLayout *layout in self.layouts) {
        [layout drawInContext:context];
    }
    
}

#pragma mark -Setter
- (void)setLayouts:(NSArray *)layouts {
    
    if ([_layouts isEqual:layouts]) {
        return;
    }
    
    _layouts = layouts;
}

@end
