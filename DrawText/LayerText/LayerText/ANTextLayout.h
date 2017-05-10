//
//  ANTextLayout.h
//  LayerText
//
//  Created by Qianrun on 17/1/16.
//  Copyright © 2017年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANTextLayout : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) CGRect boundsRect;

- (void)createFrame;

@end
