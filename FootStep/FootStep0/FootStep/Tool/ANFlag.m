
//
//  ANFlag.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANFlag.h"
#import <libkern/OSAtomic.h>

@interface ANFlag ()
@property (atomic,assign,readwrite) int32_t value;
@end

@implementation ANFlag

@synthesize value = _value;

- (int32_t)value {
    return _value;
}

- (void)setValue:(int32_t)value {
    _value = value;
}

- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}

@end