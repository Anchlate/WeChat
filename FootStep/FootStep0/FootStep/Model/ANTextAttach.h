//
//  ANTextAttach.h
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANTextAttach : NSObject

@property (nonatomic,strong) UIImage* image;
@property (nonatomic,assign) NSRange range;
@property (nonatomic,assign) CGRect imagePosition;

@end
