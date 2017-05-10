//
//  ANTextView.h
//  drawText
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWTextLayout;

@interface ANTextView : UIView

@property (nonatomic,strong) LWTextLayout* contentTextLayout;

@end