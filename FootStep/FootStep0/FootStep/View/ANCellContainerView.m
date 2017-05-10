
//
//  ANCellContainerView.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANCellContainerView.h"
#import "ANTextLayout.h"
#import "ANContainerLayer.h"

@interface ANCellContainerView ()<ANContainerLayerDelegate>

@end

@implementation ANCellContainerView

/**
 *  “default is [CALayer class]. Used when creating the underlying layer for the view.”
 *
 */
+ (Class)layerClass {
    return [ANContainerLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.opaque = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        ((ANContainerLayer *)self.layer).asyncDisplayDelegate = self;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [(ANContainerLayer *)self.layer cleanUp];
    [(ANContainerLayer *)self.layer drawContent];
}

#pragma mark -Delegate
#pragma mark -
- (BOOL)willBeginAsyncDisplay:(ANCellContainerView *)layer {
    return YES;
}

- (void)didAsyncDisplay:(ANCellContainerView *)layer context:(CGContextRef)context size:(CGSize)size {
    if ([self.delegate respondsToSelector:@selector(extraAsyncDisplayIncontext:size:)] &&
        [self.delegate conformsToProtocol:@protocol(ANContainerLayerDelegate)]) {
        [self.delegate extraAsyncDisplayIncontext:context size:size];
    }
    for (ANTextLayout* layout in self.layouts) {
        [layout drawInContext:context];
    }
}

#pragma mark -Setter
- (void)setLayouts:(NSArray *)layouts {
    
    if ([_layouts isEqual:layouts]) return;
    
    _layouts = layouts;
}


@end
