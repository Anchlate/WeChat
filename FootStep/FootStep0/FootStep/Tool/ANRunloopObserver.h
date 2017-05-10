//
//  ANRunloopObserver.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANRunloopObserver : NSObject


/**
 *  创建LWRunLoopObserver实例
 */
+ (ANRunloopObserver *)observerWithTarget:(id)target
                                 selector:(SEL)selector
                                   object:(id)object;

/**
 *  提交事件，开始执行
 */
- (void)commit;


@end
