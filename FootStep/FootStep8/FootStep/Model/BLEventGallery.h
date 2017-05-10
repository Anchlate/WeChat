//
//  BLEventGallery.h
//  BanLv
//
//  Created by Qianrun on 16/10/25.
//  Copyright © 2016年 刘飞. All rights reserved.
//

#import "JSONModel.h"

@protocol BLEventGallery <NSObject>
@end

@interface BLEventGallery : JSONModel

/*
 
 id : 5412
 imgname : "20161020154053.jpg"
 url : "http://img.autojfun.com/2016/10/20/147694925461724472.jpg"
 
 */
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, copy) NSString *imgname;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *smallImgURL;

@end