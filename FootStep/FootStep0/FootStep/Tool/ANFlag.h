//
//  ANFlag.h
//  FootStep
//
//  Created by Qianrun on 16/12/2.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANFlag : NSObject

/**
 *  获取当前Flag的值
 */
@property (atomic,assign,readonly) int32_t value;


/**
 *  Flag的值+1
 */
- (int32_t)increase;


@end
