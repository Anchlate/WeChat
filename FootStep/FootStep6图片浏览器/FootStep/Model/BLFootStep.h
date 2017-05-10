//
//  BLFootStep.h
//  BanLv
//
//  Created by Qianrun on 16/10/25.
//  Copyright © 2016年 刘飞. All rights reserved.
//

#import "JSONModel.h"
#import "BLEventMember.h"
#import "BLEventGallery.h"

@protocol BLFootStep <NSObject>
@end

//#define kFootStepNameFont [UIFont systemFontOfSize:12]
//#define kFootStepContentFont [UIFont systemFontOfSize:12]
//#define kFootStepDeviceFont [UIFont systemFontOfSize:12]

@interface BLFootStep : JSONModel

/*
 id : 839
 title : "going"
 content : "送，地点"
 orgname : ""
 linkphone : ""
 
 mobilephone : ""
 address : ""
 pathplanning : ""
 startdate : ""
 starttime : ""
 
 enddate : ""
 endtime : ""
 createdate : "2016-10-20"
 createtime : "15:40:42"
 memberid : 10137
 
 membername : "二二滴滴滴"
 memberlogo : "http://img.autojfun.com/2016/10/17/147666981141332704_SQ.png"
 membernum : 1
 likenum : 0
 commentnum : 0
 
 openstatus : 0
 status : 0
 tags : ""
 searchkeywords : ""
 devicesession : "bfbf4afa18faf24d8df9336f37475e43"
 
 fromdevice : "iPhone 6S"
 eventtype : "ACTIVITY"
 accesstype : "PRIVATE"
 viewtype : "DEFAULT"
 updatedate : "2016-10-20"
 
 updatetime : "15:40:56"
 iseventlike : false
 eventmember
 eventgallery
 
 */

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *orgname;
@property (nonatomic, copy) NSString *linkphone;

@property (nonatomic, copy) NSString *mobilephone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *pathplanning;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *starttime;

@property (nonatomic, copy) NSString *enddate;
@property (nonatomic, copy) NSString *endtime;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, assign) NSInteger memberid;

@property (nonatomic, copy) NSString *membername;
@property (nonatomic, copy) NSString *memberlogo;
@property (nonatomic, assign) NSInteger membernum;
@property (nonatomic, assign) NSInteger likenum;
@property (nonatomic, assign) NSInteger commentnum;

@property (nonatomic, assign) NSInteger openstatus;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *searchkeywords;
@property (nonatomic, copy) NSString *devicesession;

@property (nonatomic, copy) NSString *fromdevice;
@property (nonatomic, copy) NSString *eventtype;
@property (nonatomic, copy) NSString *accesstype;
@property (nonatomic, copy) NSString *viewtype;
@property (nonatomic, copy) NSString *updatedate;

@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, assign) BOOL iseventlike;
@property (nonatomic, copy) NSString *timestr;
@property (nonatomic, copy) NSArray<BLEventMember> *eventmember;
@property (nonatomic, copy) NSArray<BLEventGallery> *eventgallery;

@property (nonatomic, copy) NSString *membersName;

+ (void)getFootStepWithArray:(NSArray *)source block:(void(^)(NSArray *footSteps))block;

@end