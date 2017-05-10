//
//  CDStatus.h
//  仿朋友圈
//
//  Created by Qianrun on 16/12/1.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDStatus : NSObject

@property (nullable, nonatomic, retain) NSURL* avatar;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSArray* imgs;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *statusID;
@property (nullable, nonatomic, retain) NSArray* commentList;

@end
