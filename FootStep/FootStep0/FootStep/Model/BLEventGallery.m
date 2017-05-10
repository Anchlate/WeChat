
//
//  BLEventGallery.m
//  BanLv
//
//  Created by Qianrun on 16/10/25.
//  Copyright © 2016年 刘飞. All rights reserved.
//

#import "BLEventGallery.h"

@implementation BLEventGallery

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    
    return YES;
}

- (void)setUrl:(NSString *)url {
    
    _url = url;
    self.smallImgURL = [url stringByReplacingOccurrencesOfString:@".png" withString:@"_S.png"];
    
}

@end