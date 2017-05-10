//
//  CALayer+ANLazySetContent.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "CALayer+ANLazySetContent.h"
#import "ANRunloopObserver.h"

@implementation CALayer (ANLazySetContent)

- (void)lazySetContent:(id)contents {
    ANRunloopObserver* obeserver = [ANRunloopObserver observerWithTarget:self
                                                                selector:@selector(setContents:)
                                                                  object:contents];
    [obeserver commit];
}

@end
