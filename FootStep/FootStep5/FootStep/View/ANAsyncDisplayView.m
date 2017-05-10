
//
//  ANAsyncDisplayView.m
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANAsyncDisplayView.h"
#import "ANAsyncDisplayLayer.h"

@interface ANAsyncDisplayView ()<ANAsyncDisplayLayerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITapGestureRecognizer* tapGestureRecognizer;

@end

@implementation ANAsyncDisplayView

#pragma mark - Initialization

/**
 *  “default is [CALayer class]. Used when creating the underlying layer for the view.”
 *
 */
+ (Class)layerClass {
    return [ANAsyncDisplayLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.opaque = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        ((ANAsyncDisplayLayer *)self.layer).asyncDisplayDelegate = self;
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    return self;
}

#pragma mark - Setter & Getter

- (void)layoutSubviews {
    [super layoutSubviews];
    [(ANAsyncDisplayLayer *)self.layer cleanUp];
    [(ANAsyncDisplayLayer *)self.layer drawContent];
}

- (void)setLayouts:(NSArray *)layouts {
    if ([_layouts isEqual:layouts]) {
        return;
    }
    _layouts = layouts;
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(_didSingleTapThisView:)];
        _tapGestureRecognizer.delegate = self;
    }
    return _tapGestureRecognizer;
}

#pragma mark - LWAsyncDisplayLayerDelegate

- (BOOL)willBeginAsyncDisplay:(ANAsyncDisplayLayer *)layer {
    return YES;
}

- (void)didAsyncDisplay:(ANAsyncDisplayLayer *)layer context:(CGContextRef)context size:(CGSize)size {
    if ([self.delegate respondsToSelector:@selector(extraAsyncDisplayIncontext:size:)] &&
        [self.delegate conformsToProtocol:@protocol(ANAsyncDisplayViewDelegate)]) {
        [self.delegate extraAsyncDisplayIncontext:context size:size];
    }
    for (ANTextLayout* layout in self.layouts) {
        [layout drawInContext:context];
    }
}

#pragma mark - SignleTapGesture

- (void)_didSingleTapThisView:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint touchPoint = [tapGestureRecognizer locationInView:self];
    for (ANTextLayout* layout in self.layouts) {
        if (layout == nil) {
            continue;
        }
        CTFrameRef textFrame = layout.frame;
        if (textFrame == NULL) {
            continue;
        }
        CFArrayRef lines = CTFrameGetLines(textFrame);
        CGPoint origins[CFArrayGetCount(lines)];
        CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
        CGPathRef path = CTFrameGetPath(textFrame);
        CGRect boundsRect = CGPathGetBoundingBox(path);
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformMakeTranslation(0, boundsRect.size.height);
        transform = CGAffineTransformScale(transform, 1.f, -1.f);
        for (int i= 0; i < CFArrayGetCount(lines); i++) {
            CGPoint linePoint = origins[i];
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            CGRect flippedRect = [self _getLineBounds:line point:linePoint];
            CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
            
            CGRect adjustRect = CGRectMake(rect.origin.x + boundsRect.origin.x,
                                           rect.origin.y + boundsRect.origin.y,
                                           rect.size.width,
                                           rect.size.height);
            
            if (CGRectContainsPoint(adjustRect, touchPoint)) {
                CGPoint relativePoint = CGPointMake(touchPoint.x - CGRectGetMinX(adjustRect),
                                                    touchPoint.y - CGRectGetMinY(adjustRect));
                CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
                CTRunRef touchedRun;
                NSArray* runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
                for (NSInteger i = 0; i < runObjArray.count; i ++) {
                    CTRunRef runObj = (__bridge CTRunRef)[runObjArray objectAtIndex:i];
                    CFRange range = CTRunGetStringRange((CTRunRef)runObj);
                    if (NSLocationInRange(index, NSMakeRange(range.location, range.length))) {
                        touchedRun = runObj;
                        NSDictionary* runAttribues = (NSDictionary *)CTRunGetAttributes(touchedRun);
                        if ([runAttribues objectForKey:kLWTextLinkAttributedName]) {
                            if ([self.delegate respondsToSelector:@selector(lwAsyncDicsPlayView:didCilickedLinkWithfData:)] &&
                                [self.delegate conformsToProtocol:@protocol(ANAsyncDisplayViewDelegate)]) {
                                [self.delegate lwAsyncDicsPlayView:self didCilickedLinkWithfData:[runAttribues objectForKey:kLWTextLinkAttributedName]];
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
}

- (CGRect)_getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

- (void)_layout:(ANTextLayout *)layout drawHighLightWithAttach:(ANTextAttach *)attach {
    
}

#pragma mark - UIGestrueRecognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
