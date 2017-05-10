//
//  ANCellContainerView.h
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ANCellContainerViewDelegat <NSObject>

@end


@interface ANCellContainerView : UIView

@property (nonatomic, assign) id<ANCellContainerViewDelegat> delegate;


@end
