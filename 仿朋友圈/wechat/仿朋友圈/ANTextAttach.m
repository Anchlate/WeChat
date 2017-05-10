
//
//  ANTextAttach.m
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANTextAttach.h"

@implementation ANTextAttach

- (id)init {
    self = [super init];
    if (self) {
        self.range = NSMakeRange(0, 0);
        self.imagePosition = CGRectZero;
        self.image = nil;
    }
    return self;
}

@end
