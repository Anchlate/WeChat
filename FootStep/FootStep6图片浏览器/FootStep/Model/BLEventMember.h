//
//  BLEventMember.h
//  BanLv
//
//  Created by Qianrun on 16/10/25.
//  Copyright © 2016年 刘飞. All rights reserved.
//

#import "JSONModel.h"

@protocol BLEventMember <NSObject>
@end

@interface BLEventMember : JSONModel

/*
 id : 1841
 memberid : 10137
 membername : "二二滴滴滴"
 memberlogo : "http://img.autojfun.com/2016/10/17/147666981141332704_SQ.png"
 */


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *memberid;
@property (nonatomic, copy) NSString *membername;
@property (nonatomic, copy) NSString *memberlogo;

@end
