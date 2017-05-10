
//
//  ANCellLayout.m
//  FootStep
//
//  Created by Anchlate Lee on 16/12/4.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANCellLayout.h"
#import "ANTextParser.h"


@implementation ANCellLayout

- (id)initWithCDStatusModel:(BLFootStep *)footstep {
    self = [super init];
    if (self) {
        
        /*
        // commentList
        NSDictionary *comment1 = @{
                                   @"content" : @"内容",
                                   @"from" : @"来自",
                                   @"to" : @"A1"
                                   };
        
        NSDictionary *comment2 = @{
                                   @"content" : @"内容2",
                                   @"from" : @"来自2",
                                   @"to" : @"A2"
                                   };
        
        NSDictionary *comment3 = @{
                                   @"content" : @"内容3",
                                   @"from" : @"来自3",
                                   @"to" : @"A3"
                                   };
        
        NSArray *commentList = @[comment1, comment2, comment3];
        */
        
        
        
        static NSDateFormatter* dateFormatter;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
        });
        self.footstep = footstep;
        //avatar
        self.avatarPosition = CGRectMake(10.0f, 20.0f,40.0f, 40.0f);
        
        //name
        self.nameTextLayout = [[ANTextLayout alloc] init];
        self.nameTextLayout.text = self.footstep.membername;
        self.nameTextLayout.font = [UIFont systemFontOfSize:15.0f];
        self.nameTextLayout.textAlignment = NSTextAlignmentLeft;
        self.nameTextLayout.linespace = 2.0f;
        self.nameTextLayout.textColor = RGB(113, 129, 161, 1);
        self.nameTextLayout.boundsRect = CGRectMake(60, 20, SCREEN_WIDTH, 20);
        [self.nameTextLayout creatCTFrameRef];
        
        [self.nameTextLayout addLinkWithData:[NSString stringWithFormat:@"%@",self.footstep.membername]
                                     inRange:NSMakeRange(0, self.footstep.membername.length)
                                   linkColor:nil
                              highLightColor:[UIColor grayColor]
                              UnderLineStyle:NSUnderlineStyleNone];
        
        //content
        self.contentTextLayout = [[ANTextLayout alloc] init];
        self.contentTextLayout.text = self.footstep.content;
        self.contentTextLayout.font = [UIFont systemFontOfSize:15.0f];
        self.contentTextLayout.textColor = RGB(40, 40, 40, 1);
        self.contentTextLayout.boundsRect = CGRectMake(60.0f,50.0f,SCREEN_WIDTH - 80.0f,MAXFLOAT);
        self.contentTextLayout.linespace = 2.0f;
        [self.contentTextLayout creatCTFrameRef];
        //解析表情跟主题（[emoji] - > 表情。。#主题# 添加链接）
        //        [LWTextParser parseEmojiWithTextLayout:self.contentTextLayout];
        //        [LWTextParser parseTopicWithTextLayout:self.contentTextLayout
        //                                     linkColor:RGB(113, 129, 161, 1)
        //                                highlightColor:nil
        //                                underlineStyle:NSUnderlineStyleNone];
        
        //imgs
        NSInteger imageCount = [self.footstep.eventgallery count];
        NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSInteger row = 0;
        NSInteger column = 0;
        for (NSInteger i = 0; i < self.footstep.eventgallery.count; i ++) {
            CGRect imageRect = CGRectMake(60.0f + (column * 85.0f),
                                          60.0f + self.contentTextLayout.textHeight + (row * 85.0f),
                                          80.0f,
                                          80.0f);
            NSString* rectString = NSStringFromCGRect(imageRect);
            [tmpArray addObject:rectString];
            column = column + 1;
            if (column > 2) {
                column = 0;
                row = row + 1;
            }
        }
        CGFloat imagesHeight = 0.0f;
//        row < 3 ? (imagesHeight = (row + 1) * 85.0f):(imagesHeight = row  * 85.0f);
        (imageCount % 3) ? (imagesHeight = (row + 1) * 85.0f) : (imagesHeight = row  * 85.0f);
        self.imagePostionArray = tmpArray;
        //timeStamp
        self.dateTextLayout = [[ANTextLayout alloc] init];
        
        NSString *device = self.footstep.fromdevice;
        if (!device || !device.length) device = @"未知设备";
        self.dateTextLayout.text =  [NSString stringWithFormat:@"%@  来自%@", self.footstep.timestr, device]; //[dateFormatter stringFromDate:[NSDate date]];
        self.dateTextLayout.font = [UIFont systemFontOfSize:13.0f];
        self.dateTextLayout.textColor = [UIColor grayColor];
        self.dateTextLayout.boundsRect = CGRectMake(60, 70 + imagesHeight + self.contentTextLayout.textHeight,
                                                    SCREEN_WIDTH - 80,
                                                    20.0f);
        [self.dateTextLayout creatCTFrameRef];
        //menu
        self.menuPosition = CGRectMake(SCREEN_WIDTH - 40.0f,
                                       70.0f + self.contentTextLayout.textHeight + imagesHeight,
                                       20.0f,
                                       15.0f);
        //comment
        /*
        self.commentBgPosition = CGRectZero;
        self.commentTextLayouts = @[];
        CGRect rect = CGRectMake(60.0f, 70.0f + self.contentTextLayout.textHeight + imagesHeight + 25.0f, SCREEN_WIDTH - 80, 20);
        CGFloat offsetY = 0.0f;
        if (commentList.count != 0 && commentList != nil) {
            NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:commentList.count];
            for (NSDictionary* commentDict in commentList) {
                NSString* to = commentDict[@"to"];
                if (to.length != 0) {
                    NSString* commentString = [NSString stringWithFormat:@"%@回复%@:%@",commentDict[@"from"],commentDict[@"to"],commentDict[@"content"]];
                    ANTextLayout* commentLayout = [[ANTextLayout alloc] init];
                    commentLayout.text = commentString;
                    commentLayout.font = [UIFont systemFontOfSize:14.0f];
                    commentLayout.textAlignment = NSTextAlignmentLeft;
                    commentLayout.linespace = 2.0f;
                    commentLayout.textColor = RGB(40, 40, 40, 1);
                    commentLayout.boundsRect = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, 20.0f);
                    [commentLayout creatCTFrameRef];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"from"]]
                                           inRange:NSMakeRange(0,[(NSString *)commentDict[@"from"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"to"]]
                                           inRange:NSMakeRange([(NSString *)commentDict[@"from"] length] + 2,[(NSString *)commentDict[@"to"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
                    
                    
                    //                    [LWTextParser parseEmojiWithTextLayout:commentLayout];
                    //                    [LWTextParser parseTopicWithTextLayout:commentLayout
                    //                                                 linkColor:RGB(113, 129, 161, 1)
                    //                                            highlightColor:nil
                    //                                            underlineStyle:NSUnderlineStyleNone];
                    
                    
                    [tmp addObject:commentLayout];
                    offsetY += commentLayout.textHeight;
                } else {
                    NSString* commentString = [NSString stringWithFormat:@"%@:%@",commentDict[@"from"],commentDict[@"content"]];
                    ANTextLayout* commentLayout = [[ANTextLayout alloc] init];
                    commentLayout.text = commentString;
                    commentLayout.font = [UIFont systemFontOfSize:14.0f];
                    commentLayout.textAlignment = NSTextAlignmentLeft;
                    commentLayout.linespace = 2.0f;
                    commentLayout.textColor = RGB(40, 40, 40, 1);
                    commentLayout.boundsRect = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, 20.0f);
                    [commentLayout creatCTFrameRef];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"from"]]
                                           inRange:NSMakeRange(0,[(NSString *)commentDict[@"from"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
                    
                    //                    [LWTextParser parseEmojiWithTextLayout:commentLayout];
                    //                    [LWTextParser parseTopicWithTextLayout:commentLayout
                    //                                                 linkColor:RGB(113, 129, 161, 1)
                    //                                            highlightColor:nil
                    //                                            underlineStyle:NSUnderlineStyleNone];
                    
                    [tmp addObject:commentLayout];
                    offsetY += commentLayout.textHeight;
                }
            }
            self.commentTextLayouts = tmp;
            self.commentBgPosition = CGRectMake(60.0f, 70.0f + self.contentTextLayout.textHeight + imagesHeight + 25.0f, SCREEN_WIDTH - 80, offsetY + 15.0f);
        }
        */
        
        //cellHeight
        self.cellHeight = 100.0f + imagesHeight + self.contentTextLayout.textHeight + self.commentBgPosition.size.height + 5.0f;
    }
    return self;
}

@end
