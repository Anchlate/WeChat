//
//  ANTextAttach.h
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ANTextAttach : NSObject

@property (nonatomic,strong) UIImage* image;
@property (nonatomic,assign) NSRange range;
@property (nonatomic,assign) CGRect imagePosition;

@end
