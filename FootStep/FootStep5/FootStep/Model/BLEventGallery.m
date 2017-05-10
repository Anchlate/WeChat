
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
    
    NSString *pathExtension = [url pathExtension];
    
    if ([pathExtension isEqualToString:@"JPG"]) {
        
        self.smallImgURL = [url stringByReplacingOccurrencesOfString:@".JPG" withString:@"_S.JPG"];
        
    } else if ([pathExtension isEqualToString:@"jpg"]) {
        
        self.smallImgURL = [url stringByReplacingOccurrencesOfString:@".jpg" withString:@"_S.jpg"];
        
    } else if ([pathExtension isEqualToString:@"PNG"]) {
        
        self.smallImgURL = [url stringByReplacingOccurrencesOfString:@".PNG" withString:@"_S.PNG"];
        
    } else if ([pathExtension isEqualToString:@"png"]) {
        
        self.smallImgURL = [url stringByReplacingOccurrencesOfString:@".png" withString:@"_S.png"];
    }
    
}

@end