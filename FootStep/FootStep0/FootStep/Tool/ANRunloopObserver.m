
//
//  ANRunloopObserver.m
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANRunloopObserver.h"

@interface ANRunloopObserver ()

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) id object;

@end

static NSMutableSet* transactionSet = nil;

static void ANRunLoopObserverCallBack(CFRunLoopObserverRef observer,
                                      CFRunLoopActivity activity,
                                      void *info) {
    if (transactionSet.count == 0) return;
    NSSet* currentSet = transactionSet;
    transactionSet = [[NSMutableSet alloc] init];
    [currentSet enumerateObjectsUsingBlock:^(ANRunloopObserver* observer, BOOL* stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [observer.target performSelector:observer.selector withObject:observer.object];
#pragma clang diagnostic pop
    }];
}

static void ANRunLoopObserverSetup() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transactionSet = [[NSMutableSet alloc] init];
        CFRunLoopRef runloop = CFRunLoopGetMain();
        CFRunLoopObserverRef observer;
        observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                           kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                           true,
                                           0xFFFFFF,
                                           ANRunLoopObserverCallBack, NULL);
        CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
        CFRelease(observer);
    });
}

@implementation ANRunloopObserver

+ (ANRunloopObserver *)observerWithTarget:(id)target
                                 selector:(SEL)selector
                                   object:(id)object {
    if (!target || !selector) {
        return nil;
    }
    ANRunloopObserver* observer = [[ANRunloopObserver alloc] init];
    observer.target = target;
    observer.selector = selector;
    observer.object = object;
    return observer;
}

- (void)commit {
    if (!_target || !_selector) {
        return;
    }
    ANRunLoopObserverSetup();
    [transactionSet addObject:self];
}

- (NSUInteger)hash {
    long v1 = (long)((void *)_selector);
    long v2 = (long)_target;
    return v1 ^ v2;
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if (![object isMemberOfClass:self.class]){
        return NO;
    }
    ANRunloopObserver* other = object;
    return other.selector == _selector && other.target == _target;
}

@end
