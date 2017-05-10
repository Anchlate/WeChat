//
//  ANCellLayout.h
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ANTextLayout, BLFootStep;

@interface ANCellLayout : NSObject

@property (nonatomic,strong) BLFootStep *footStep;
@property (nonatomic,strong) ANTextLayout* nameTextLayout;
@property (nonatomic,strong) ANTextLayout* contentTextLayout;
@property (nonatomic,strong) ANTextLayout* dateTextLayout;

@property (nonatomic,assign) CGRect avatarPosition;
@property (nonatomic,assign) CGRect menuPosition;
@property (nonatomic,assign) CGRect likesAndCommentsPosition;
@property (nonatomic,copy) NSArray* imagePostionArray;

@property (nonatomic,assign) CGFloat textHeight;
@property (nonatomic,assign) CGFloat imagesHeight;
@property (nonatomic,assign) CGFloat likesAndCommentsHeight;
@property (nonatomic,assign) CGRect commentBgPosition;
@property (nonatomic,copy) NSArray* commentTextLayouts;
@property (nonatomic,assign) CGFloat cellHeight;

- (id)initWithFootStep:(BLFootStep *)FootStep;


@end