//
//  ANCellLayout.h
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANTextLayout.h"
#import "ANTextParser.h"
//#import "CDStatus.h"
#import "BLFootStep.h"

@interface ANCellLayout : NSObject

@property (nonatomic,strong) BLFootStep* footstep;
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

- (id)initWithCDStatusModel:(BLFootStep *)footstep;


@end
